import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:practical/app/constant/app_constanst.dart';
import 'package:practical/app/routes/app_routes.dart';
import 'package:practical/app/services/connectivity_service.dart';
import 'package:practical/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/services/api_service.dart';

class HomeController extends GetxController {
  var posts = <Post>[].obs;
  final ApiService apiService = ApiService();
  Map<int, Timer?> timers = {};

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  Future<void> loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsJson = prefs.getString('posts');

    if (postsJson != null) {
      List<dynamic> data = json.decode(postsJson);
      posts.value = data.map((json) => Post.fromJson(json)).toList();
    } else {
      posts.value = await apiService.fetchPosts();
      await savePostsToLocal();
    }
    update();
  }

  Future<void> savePostsToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postsJson = json.encode(posts.map((post) {
      log('post --> ${post.toJson()}');
      return post.toJson();
    }).toList());
    prefs.setString('posts', postsJson);
    update();
  }

  Future<void> markAsRead(int id) async {
    final post = posts.firstWhere((p) => p.id == id);
    post.isRead = true;
    await savePostsToLocal();
    posts.refresh();
    update();
  }

  Future<void> updateTimer(int id, Duration elapsedTime) async {
    final post = posts.firstWhere((p) => p.id == id);
    post.elapsedTime = elapsedTime;
    posts.refresh();
    await savePostsToLocal();
  }

  void pauseTimer(int id) {
    timers[id]?.cancel();
    timers[id] = null;
    update();
  }

  void resumeTimer(int id) {
    final postToResume = posts.firstWhere((p) => p.id == id);
    startTimer(postToResume);
    update();
  }

  void startTimer(Post post) {
    if (timers[post.id] != null) return;

    timers[post.id] = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await updateTimer(post.id, post.elapsedTime + const Duration(seconds: 1));
      if (post.timerDuration <= post.elapsedTime) {
        timer.cancel();
        timers[post.id] = null;
      }
    });
    update();
  }

  void handlePostTap(int id, ConnectivityService connectivityService) async {
    bool isConnected = await connectivityService.isConnected();
    if (!isConnected) {
      await markAsRead(id);
     gotoDetailsPage(id);
    } else {
      Get.snackbar(
        'No Internet Connection',
        'Please check your internet connection and try again.',
        backgroundColor: AppColorConstants.colorWhite,
        snackPosition: SnackPosition.TOP,
      );
    }
    update();
  }

  Duration getRemainingTime(int postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    return post.timerDuration - post.elapsedTime;
  }
}
