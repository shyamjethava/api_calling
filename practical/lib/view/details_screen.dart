import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/app/constant/app_constanst.dart';
import 'package:practical/controller/home_controller.dart';
import 'package:practical/controller/post_details_controller.dart';
import 'package:practical/models/post_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController postController = Get.find();

    return GetBuilder(
      init: PostDetailsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColorConstants.colorBlack,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColorConstants.colorWhite),
            backgroundColor: AppColorConstants.colorBlack,
            title: const Text(
              AppStringConstants.postDetails,
              style: TextStyle(color: AppColorConstants.colorWhite),
            ),
          ),
          body: FutureBuilder<Post>(
            future:
                postController.apiService.fetchPostById(controller.postId ?? 1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final post = snapshot.data!;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColorConstants.colorWhite),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post.body,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: AppColorConstants.colorWhite),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: Text(AppStringConstants.noDataFound));
              }
            },
          ),
        );
      },
    );
  }
}
