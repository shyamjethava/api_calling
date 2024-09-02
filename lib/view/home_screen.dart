import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/app/constant/app_constanst.dart';
import 'package:practical/app/services/connectivity_service.dart';
import 'package:practical/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController postController = Get.put(HomeController());
  final ConnectivityService connectivityService = ConnectivityService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColorConstants.colorWhite,
            appBar: AppBar(
              backgroundColor: AppColorConstants.colorBlack,
              title: const Text(
                AppStringConstants.home,
                style: TextStyle(color: AppColorConstants.colorWhite),
              ),
            ),
            body: ListView.builder(
              itemCount: postController.posts.length,
              itemBuilder: (context, index) {
                final post = postController.posts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    tileColor: post.isRead
                        ? AppColorConstants.colorWhite
                        : AppColorConstants.colorPrimary,
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          post.id.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Text(
                      post.body,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: TimerWidget(postId: post.id),
                    onTap: () => postController.handlePostTap(
                        post.id, connectivityService),
                  ),
                );
              },
            ));
      },
    );
  }
}

class TimerWidget extends StatefulWidget {
  final int postId;

  const TimerWidget({super.key, required this.postId});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Duration _remainingTime;
  late Timer _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    _remainingTime = Duration(
        seconds: _random.nextInt(30) +
            10); // Random duration between 10 and 40 seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer, size: 20, color: Colors.black),
        const SizedBox(width: 4),
        Text(
          "${_remainingTime.inMinutes}:${_remainingTime.inSeconds % 60}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
