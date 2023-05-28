import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  late final RxBool isLogin;
  late final RxBool isIntroCompleted;
  late final Rx<UserModel> user;

  UserController() {
    isLogin = false.obs;
    isIntroCompleted = false.obs;
    user = UserModel().obs;
  }

  set setUser(UserModel data) => user.value = data;
  set setIsIntroCompleted(bool data) => isIntroCompleted.value = data;
  set setIsLogin(bool data) => isLogin.value = data;
}
