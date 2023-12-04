import 'package:flutter_hello_my_doctor/controllers/select_doctor_controller.dart';
import 'package:get/get.dart';

class SelectDoctorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectDoctorController());
  }
}
