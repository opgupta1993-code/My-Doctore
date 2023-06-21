import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    _userController = Get.find<UserController>();
  }

  Future<void> onGetStartedPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final DateTime dateTime = DateTime.now();

    if (dateTime.isAfter(DateTime(2023, 6, 25))) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }

    Routes.introPageViewScreen();
  }
}
