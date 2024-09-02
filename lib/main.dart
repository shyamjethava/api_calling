import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/app/constant/app_constanst.dart';
import 'package:practical/app/routes/route_helper.dart';
import 'view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStringConstants.appName,
      initialRoute: RouteConstant.initial,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(microseconds: 800),
      getPages: RouteHelper.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
