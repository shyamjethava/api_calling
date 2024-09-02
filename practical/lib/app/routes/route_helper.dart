import 'package:get/get.dart';
import 'package:practical/view/details_screen.dart';
import 'package:practical/view/home_screen.dart';


class RouteConstant {
  // ===================== Main Routes =====================
  static const String initial = '/';
  static const String detailsPage = '/details_page';

}


mixin RouteHelper {
  String initial = '/';
  String detailsPage = '/details_page';


  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => const HomeScreen()),
    GetPage(name: RouteConstant.detailsPage, page: () => const DetailScreen()),
  ];
}

