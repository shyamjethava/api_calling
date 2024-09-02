import 'package:get/get.dart';

class PostDetailsController extends GetxController {
  int? postId;

  @override
  void onInit() {
    postId = Get.arguments['post_id'];
    super.onInit();
  }
}
