import 'package:flutter_hello_my_doctor/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class DrawerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrawerController());
    Get.lazyPut(() => HomeController());
  }
}
