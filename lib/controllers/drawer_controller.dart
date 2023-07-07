import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class DrawerController extends GetxController {
  late final GlobalKey<ScaffoldState> _sfKey;

  late final SelectCityController _selectCityController;

  @override
  void onInit() {
    super.onInit();

    _sfKey = GlobalKey<ScaffoldState>();

    _selectCityController = Get.find<SelectCityController>();
  }

  Future<void> onDrawerMenuPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_sfKey.currentState != null && !_sfKey.currentState!.isDrawerOpen) {
      _sfKey.currentState!.openDrawer();
    }
  }

  Future<void> onProfilePressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_sfKey.currentState != null && _sfKey.currentState!.isDrawerOpen) {
      _sfKey.currentState!.closeDrawer();
    }
    await Future.delayed(const Duration(milliseconds: 130));

    Routes.profileScreen();
  }

  Future<void> onDrawerItemPressed(int type) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_sfKey.currentState != null && _sfKey.currentState!.isDrawerOpen) {
      _sfKey.currentState!.closeDrawer();
    }
    await Future.delayed(const Duration(milliseconds: 130));

    switch (type) {
      case 0:
        _selectCityController.afterLogin = false;

        Routes.selectCityScreen(afterLogin: false);
        break;
      case 1:
        Routes.appointmentsScreen();
        break;
      case 2:
      case 3:
      case 4:
        Routes.comingSoonScreen();
        break;
      case 5:
        Routes.notificationsScreen();
        break;
      case 6:
        Routes.webviewScreen(Constants.aboutUsUrl);
        break;
      case 7:
        Routes.webviewScreen(Constants.galleryUrl);
        break;
      case 8:
        Routes.webviewScreen(Constants.tcUrl);
        break;
      case 9:
        Routes.webviewScreen(Constants.ppUrl);
        break;
      case 10:
        Routes.webviewScreen(Constants.rpUrl);
        break;
      case 11:
        Routes.webviewScreen(Constants.helpUrl);
        break;
      case 12:
        Utils.logout();
        break;
    }
  }

  GlobalKey<ScaffoldState> get sfKey => _sfKey;
}
