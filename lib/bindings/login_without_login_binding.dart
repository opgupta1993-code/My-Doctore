import 'package:get/get.dart';

import '../controllers/login_without_login_controller.dart';

class LoginWithoutLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginWithoutLoginController());
  }
}
