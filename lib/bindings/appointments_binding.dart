import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppointmentsController());
  }
}
