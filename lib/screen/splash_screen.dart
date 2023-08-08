import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';

import '../controller/splash_controller.dart';
import '../helper/route_helper.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../view/no_internet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (controller) {
        controller.checkToken().then((isOk) {
          Timer(const Duration(seconds: 1), () async {
            isOk?Get.offNamed(RouteHelper.home):Get.offNamed(RouteHelper.getSignInRoute());
          });
        });
        return Center(
          child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.logo, width: 200),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    // Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
                  ],
                )
        );
      }),
    );
  }
}
