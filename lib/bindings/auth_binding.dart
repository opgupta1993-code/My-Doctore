import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  final String _tag;

  AuthBinding(this._tag);

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(_tag), tag: _tag);
  }
}
