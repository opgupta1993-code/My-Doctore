import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../networking/network_calls.dart';
import '../routes/routes.dart';
import '../utils/firebase_util.dart';
import '../utils/utils.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  late final RxBool loading;
  late final RxBool agree;

  late final GlobalKey<FormState> _formKey;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController pwdController;

  late final UserController _userController;

  final String _tag;

  AuthController(this._tag);

  @override
  void onInit() {
    super.onInit();

    loading = false.obs;
    _userController = Get.find<UserController>();

    switch (_tag) {
      case "signupScreen":
        _formKey = GlobalKey<FormState>();

        nameController = TextEditingController();
        emailController = TextEditingController();
        pwdController = TextEditingController();

        agree = false.obs;

        break;

      case "loginScreen":
        _formKey = GlobalKey<FormState>();
        emailController = TextEditingController();
        pwdController = TextEditingController();

        break;
    }
  }

  Future<void> _login() async {
    final Map<String, dynamic> data = {
      "email": emailController.text,
      "password": pwdController.text,
      "device_id": await FirebaseUtil.getFCMToken(),
    };

    final Map res = await NetworkCalls.login(data);

    if (res["status"] == "200") {
      final Map data = res["result"] ?? {};

      final UserModel userModel = UserModel.fromJson(data);
      _userController.setUser = userModel;

      await _performAfterLoginTask(data);
    } else {
      Utils.showToast("${res["msg"]}");
    }

    loading.value = false;
  }

  Future<void> _performAfterLoginTask(Map data) async {
    final SharedPreferences preferences = Get.find();

    await preferences.setBool("login", true);
    await preferences.setString("userData", json.encode(data));

    _userController.setIsLogin = true;

    Routes.drawerScreen();
  }

  Future<void> _signup() async {
    final Map<String, dynamic> data = {
      "name": nameController.text,
      "email": emailController.text,
      "password": pwdController.text,
      "cpassword": pwdController.text,
    };

    final Map res = await NetworkCalls.signup(data);

    if (res["status"] == "200") {
    } else {
      Utils.showToast("${res["msg"]}");
    }

    loading.value = false;
  }

  void onAgreePressed() {
    agree.value = !agree.value;
  }

  Future<void> onLoginJoinUsPressed() async {
    Utils.removeFocus();
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.signupScreen();
  }

  Future<void> onSignupLoginPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Get.back();
  }

  Future<void> onLoginLoginPressed() async {
    Utils.removeFocus();
    if (!_formKey.currentState!.validate()) return;

    await Future.delayed(const Duration(milliseconds: 100));
    loading.value = true;

    await _login();
  }

  Future<void> onSignupSignupPressed() async {
    Utils.removeFocus();

    if (!_formKey.currentState!.validate()) return;

    await Future.delayed(const Duration(milliseconds: 100));
    loading.value = true;

    await _signup();
  }

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onClose() {
    switch (_tag) {
      case "signupScreen":
        nameController.dispose();
        emailController.dispose();
        pwdController.dispose();
        break;

      case "loginScreen":
        emailController.dispose();
        pwdController.dispose();
        break;
    }
    super.onClose();
  }
}
