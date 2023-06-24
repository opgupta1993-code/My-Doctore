import 'package:flutter_hello_my_doctor/controllers/notifications_controller.dart';
import 'package:get/get.dart';

class NotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
