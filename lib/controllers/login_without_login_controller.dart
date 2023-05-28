import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

class LoginWithoutLoginController extends GetxController {
  Future<void> onButtonPressed(int type) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (type == 0) {
      Routes.loginScreen();
    } else {
      Routes.drawerScreen();
    }
  }
}
