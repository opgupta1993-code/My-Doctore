import 'package:flutter_hello_my_doctor/controllers/doctor_details_controller.dart';
import 'package:get/get.dart';

class DoctorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorDetailsController());
  }
}
