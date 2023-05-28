import 'package:flutter_hello_my_doctor/controllers/drawer_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final DrawerController _drawerController;

  @override
  void onInit() {
    super.onInit();

    _drawerController = Get.find<DrawerController>();
  }

  void onDrawerMenuPressed() {
    _drawerController.onDrawerMenuPressed();
  }

  void onSeeAllDoctorsPressed() {}

  Future<void> onServiceSelected() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.selectDoctorCategoryScreen();
  }
}
