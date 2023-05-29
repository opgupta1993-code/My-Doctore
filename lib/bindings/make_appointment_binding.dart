import 'package:flutter_hello_my_doctor/controllers/make_appointment_controller.dart';
import 'package:get/get.dart';

class MakeAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MakeAppointmentController());
  }
}
