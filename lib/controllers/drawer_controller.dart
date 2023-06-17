import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';

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
      case -1:
        _selectCityController.afterLogin = false;

        Routes.selectCityScreen(afterLogin: false);
        break;

      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        // Routes.comingSoonScreen();
        break;

      case 8:
        Utils.logout();
        break;
    }
  }

  GlobalKey<ScaffoldState> get sfKey => _sfKey;
}
