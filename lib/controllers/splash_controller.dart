import 'dart:async';

import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> onGetStartedPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.introPageViewScreen();
  }
}
