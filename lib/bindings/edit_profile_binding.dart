import 'package:flutter_hello_my_doctor/controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
