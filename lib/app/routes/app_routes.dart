import 'package:get/get.dart';
import 'package:practical/app/routes/route_helper.dart';

void initialRoute() => RouteConstant.initial;

gotoDetailsPage(int postID) => Get.toNamed(RouteConstant.detailsPage,arguments: {'post_id': postID});

void gotoBack() => Get.back();
