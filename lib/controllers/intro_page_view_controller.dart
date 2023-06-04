import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../screens/intro/intro_screen.dart';
import 'user_controller.dart';

class IntroPageViewController extends GetxController {
  late final RxInt currentIndex;

  late final PageController _pageController;
  late final List<Widget> _screensList;

  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    currentIndex = 0.obs;

    _userController = Get.find<UserController>();

    _pageController = PageController(
      keepPage: true,
      initialPage: 0,
    );

    _screensList = [
      IntroScreen(
        Constants.introOneTitle,
        Constants.introOneDesc,
        Constants.introOneArtworkPath,
      ),
      IntroScreen(
        Constants.introTwoTitle,
        Constants.introTwoDesc,
        Constants.introTwoArtworkPath,
        reverseTopGradient: true,
      ),
      IntroScreen(
        Constants.introThreeTitle,
        Constants.introThreeDesc,
        Constants.introThreeArtworkPath,
      ),
    ];
  }

  void onPageChange(int page) {
    currentIndex.value = page;
  }

  Future<void> onGetStartedPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (currentIndex.value == _screensList.length - 1) {
      // final SharedPreferences preferences = Get.find();
      // await preferences.setBool("intro", true);
      if (_userController.isLogin.value) {
        Routes.selectCityScreen();
      } else {
        Routes.loginWithoutLoginScreen();
      }
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }

  Future<void> onSkipPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (_userController.isLogin.value) {
      Routes.selectCityScreen();
    } else {
      Routes.loginWithoutLoginScreen();
    }
  }

  PageController get pageController => _pageController;
  List<Widget> get screenList => _screensList;

  @override
  void onClose() {
    _pageController.dispose();

    super.onClose();
  }
}
