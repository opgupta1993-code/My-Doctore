import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Future<void> onUpdatePressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.editProfileScreen();
  }
}
