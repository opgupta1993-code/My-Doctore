import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  late final GlobalKey<ScaffoldState> _sfKey;

  @override
  void onInit() {
    super.onInit();

    _sfKey = GlobalKey<ScaffoldState>();
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
        break;

      case 1:
        break;

      case 2:
        break;

      case 3:
        break;

      case 8:
        Utils.logout();
        break;
    }
  }

  GlobalKey<ScaffoldState> get sfKey => _sfKey;
}
