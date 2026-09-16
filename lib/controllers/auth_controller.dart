import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/utils/firebase_util.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../networking/network_calls.dart';
import '../routes/routes.dart';
import '../utils/utils.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  late final RxBool loading,
      fOneLoading,
      fTwoLoading,
      fThreeLoading,
      otpVerificationLoading,
      agree,
      _forgotOneSheet,
      _forgotTwoSheet,
      _forgotThreeSheet,
      _otpVerificationSheet,
      enableResendOTP;

  late final RxString resendOTPRemainingTime;

  late final GlobalKey<FormState> _formKey;
  late final GlobalKey<FormState> _forgotOneFormKey;
  late final GlobalKey<FormState> _forgotTwoFormKey;
  late final GlobalKey<FormState> _forgotThreeFormKey;
  late final GlobalKey<FormState> _otpVerificationFormKey;

  late final TextEditingController nameController;
  late final TextEditingController mobileController;
  late final TextEditingController emailController;
  late final TextEditingController pwdController;
  late final TextEditingController fMobileController;
  late final TextEditingController fOTPController;
  late final TextEditingController fPwdController;
  late final TextEditingController fCPwdController;
  late final TextEditingController otpController;

  StreamSubscription? _forgotOneBottomSheetStateSubscription,
      _forgotTwoBottomSheetStateSubscription,
      _forgotThreeBottomSheetStateSubscription,
      _otpVerificationBottomSheetStateSubscription;

  bool? _isForgotOneSheetOpen,
      _isForgotTwoSheetOpen,
      _isForgotThreeSheetOpen,
      _isOTPVerificationSheetOpen;

  Timer? _timer;

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
        otpVerificationLoading = false.obs;
        _otpVerificationSheet = false.obs;
        resendOTPRemainingTime = "01:00".obs;
        enableResendOTP = false.obs;

        _isOTPVerificationSheetOpen = false;

        _formKey = GlobalKey<FormState>();
        _otpVerificationFormKey = GlobalKey<FormState>();

        nameController = TextEditingController();
        emailController = TextEditingController();
        mobileController = TextEditingController();
        pwdController = TextEditingController();
        otpController = TextEditingController();

        agree = false.obs;

        break;

      case "loginScreen":
        fOneLoading = false.obs;
        fTwoLoading = false.obs;
        fThreeLoading = false.obs;

        _forgotOneSheet = false.obs;
        _forgotTwoSheet = false.obs;
        _forgotThreeSheet = false.obs;
        _isForgotOneSheetOpen = false;
        _isForgotTwoSheetOpen = false;
        _isForgotThreeSheetOpen = false;

        _formKey = GlobalKey<FormState>();
        _forgotOneFormKey = GlobalKey<FormState>();
        _forgotTwoFormKey = GlobalKey<FormState>();
        _forgotThreeFormKey = GlobalKey<FormState>();
        mobileController = TextEditingController();
        pwdController = TextEditingController();
        fMobileController = TextEditingController();
        fOTPController = TextEditingController();
        fPwdController = TextEditingController();
        fCPwdController = TextEditingController();

        break;
    }
  }

  Future<void> _login() async {
    final Map<String, dynamic> data = {
      "mobile_no": mobileController.text,
      "password": pwdController.text,
      "device_id": await FirebaseUtil.getFCMToken(),
    };

    final Map res = await NetworkCalls.login(data);

    if (res["status"] == "200") {
      final Map data = res["data"] ?? {};

      final UserModel userModel = UserModel.fromJson(data);

      _userController.setUser = userModel;

      await _performAfterLoginTask(data);
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> _performAfterLoginTask(Map data) async {
    final SharedPreferences preferences = Get.find();

    await preferences.setBool("login", true);
    await preferences.setString("userData", json.encode(data));

    _userController.setIsLogin = true;

    final bool isDirectLogin = Get.arguments["isDirectLogin"];

    if (isDirectLogin) {
      Routes.selectCityScreen(afterLogin: true);
    } else {
      final String? previousRoute = Get.arguments["previousRoute"];

      if (previousRoute == null) {
        Get.back();
      } else {
        Get.until((route) => route.settings.name == previousRoute);
      }
    }
  }

  Future<void> _signup() async {
    final Map<String, dynamic> data = {
      "username": nameController.text,
      "mobile_no": mobileController.text,
      // "email": emailController.text,
      "password": pwdController.text,
      "confirm_password": pwdController.text,
      "device_id": await FirebaseUtil.getFCMToken(),
    };

    final Map res = await NetworkCalls.signup(data);

    if (res["status"] == "200") {
      // Utils.showToast("Registered Successfully", color: Colors.green);
      // Get.until((route) => route.settings.name == "/loginScreen");

      _openOTPVerificationBottomSheet();
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> _verifyOTP() async {
    final Map<String, dynamic> data = {
      "mobile_no": mobileController.text,
      "otp": otpController.text,
    };

    final Map res = await NetworkCalls.verifyOTP(data);

    if (res["status"] == "200") {
      Utils.showToast("Registered Successfully", color: Colors.green);
      Get.until((route) => route.settings.name == "/loginScreen");
    } else {
      Utils.showToast("${res["message"]}");
    }

    otpVerificationLoading.value = false;
  }

  Future<void> _resendOTP() async {
    final Map<String, dynamic> data = {"mobile_no": mobileController.text};

    await NetworkCalls.resendOTP(data);
  }

  Future<void> _sendForgotPasswordOTP() async {
    final Map<String, dynamic> data = {"mobile_no": fMobileController.text};

    final Map res = await NetworkCalls.sendForgotPasswordOTP(data);

    if (res["status"] == "200") {
      if (_isForgotOneSheetOpen != null && _isForgotOneSheetOpen!) {
        _forgotOneSheet.value = !_forgotOneSheet.value;
        await Future.delayed(const Duration(milliseconds: 150));

        _forgotTwoSheet.value = !_forgotTwoSheet.value;
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    fOneLoading.value = false;
  }

  Future<void> _verifyForgotPasswordOTP() async {
    final Map<String, dynamic> data = {
      "mobile_no": fMobileController.text,
      "otp": fOTPController.text,
    };

    final Map res = await NetworkCalls.verifyForgotPasswordOTP(data);

    if (res["status"] == "200") {
      if (_isForgotTwoSheetOpen != null && _isForgotTwoSheetOpen!) {
        _forgotTwoSheet.value = !_forgotTwoSheet.value;

        await Future.delayed(const Duration(milliseconds: 150));

        _forgotThreeSheet.value = !_forgotThreeSheet.value;
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    fTwoLoading.value = false;
  }

  Future<void> _resetPassword() async {
    final Map<String, dynamic> data = {
      "mobile_no": fMobileController.text,
      "new_password": fPwdController.text,
      "confirm_password": fCPwdController.text,
    };

    final Map res = await NetworkCalls.resetPassword(data);

    if (res["status"] == "200") {
      if (_isForgotThreeSheetOpen != null && _isForgotThreeSheetOpen!) {
        _forgotThreeSheet.value = !_forgotThreeSheet.value;

        await Future.delayed(const Duration(milliseconds: 100));
      }

      Utils.showToast("Password reset successfully", color: Colors.green);
    } else {
      Utils.showToast("${res["message"]}");
    }

    fThreeLoading.value = false;
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

    if (!agree.value) {
      Utils.showToast("Please accept terms of service & privacy policy");
      return;
    }

    await Future.delayed(const Duration(milliseconds: 100));
    loading.value = true;

    await _signup();
  }

  void onForgotPasswordPressed() {
    Utils.removeFocus();

    _forgotOneSheet.value = !_forgotOneSheet.value;
  }

  Future<void> listenForgotOneBottomSheetState(Function showBottomSheet) async {
    _forgotOneBottomSheetStateSubscription =
        _forgotOneSheet.listen((data) async {
      if (_isForgotOneSheetOpen == null || !_isForgotOneSheetOpen!) {
        // sheet is open
        _isForgotOneSheetOpen = true;

        await showBottomSheet();

        // sheet is closed
        _isForgotOneSheetOpen = false;
      } else {
        _isForgotOneSheetOpen = false;
        Get.back(closeOverlays: true);
      }
    });
  }

  Future<void> listenForgotTwoBottomSheetState(Function showBottomSheet) async {
    _forgotTwoBottomSheetStateSubscription =
        _forgotTwoSheet.listen((data) async {
      if (_isForgotTwoSheetOpen == null || !_isForgotTwoSheetOpen!) {
        // sheet is open
        _isForgotTwoSheetOpen = true;

        await showBottomSheet();

        // sheet is closed
        _isForgotTwoSheetOpen = false;
      } else {
        _isForgotTwoSheetOpen = false;
        Get.back(closeOverlays: true);
      }
    });
  }

  Future<void> listenForgotThreeBottomSheetState(
      Function showBottomSheet) async {
    _forgotThreeBottomSheetStateSubscription =
        _forgotThreeSheet.listen((data) async {
      if (_isForgotThreeSheetOpen == null || !_isForgotThreeSheetOpen!) {
        // sheet is open
        _isForgotThreeSheetOpen = true;

        await showBottomSheet();

        // sheet is closed
        _isForgotThreeSheetOpen = false;
      } else {
        _isForgotThreeSheetOpen = false;
        Get.back(closeOverlays: true);
      }
    });
  }

  Future<void> listenOTPVerificationBottomSheetState(
    Function showBottomSheet,
  ) async {
    _otpVerificationBottomSheetStateSubscription =
        _otpVerificationSheet.listen((data) async {
      if (_isOTPVerificationSheetOpen == null ||
          !_isOTPVerificationSheetOpen!) {
        // sheet is open
        _isOTPVerificationSheetOpen = true;
        resendOTPRemainingTime.value = "01:00";

        await showBottomSheet();

        // sheet is closed
        _isOTPVerificationSheetOpen = false;
      } else {
        _isOTPVerificationSheetOpen = false;
        resendOTPRemainingTime.value = "01:00";
        Get.back(closeOverlays: true);
      }
    });
  }

  void _openOTPVerificationBottomSheet() {
    _startResendOTPTimer();
    _otpVerificationSheet.value = !_otpVerificationSheet.value;
  }

  Future<void> onForgotOneContinuePressed() async {
    Utils.removeFocus();

    if (!_forgotOneFormKey.currentState!.validate()) {
      return;
    }

    fOneLoading.value = true;
    await _sendForgotPasswordOTP();
  }

  Future<void> onForgotTwoContinuePressed() async {
    Utils.removeFocus();

    if (!_forgotTwoFormKey.currentState!.validate()) {
      return;
    }

    fTwoLoading.value = true;
    await _verifyForgotPasswordOTP();
  }

  Future<void> onForgotUpdatePasswordPressed() async {
    Utils.removeFocus();

    if (!_forgotThreeFormKey.currentState!.validate()) {
      return;
    }

    fThreeLoading.value = true;
    await _resetPassword();
  }

  Future<void> onVerifyPressed() async {
    if (!_otpVerificationFormKey.currentState!.validate()) return;

    await Future.delayed(const Duration(milliseconds: 100));

    otpVerificationLoading.value = true;

    await _verifyOTP();
  }

  Future<void> onResendOTPPressed() async {
    if (!enableResendOTP.value) return;

    enableResendOTP.value = false;
    await _resendOTP();
    resendOTPRemainingTime.value = "01:00";
    _startResendOTPTimer();
  }

  void _startResendOTPTimer() {
    _timer?.cancel();

    int seconds = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      --seconds;

      if (seconds == 60) {
        resendOTPRemainingTime.value = "01:00";
      } else if (seconds >= 10) {
        resendOTPRemainingTime.value = "00:$seconds";
      } else {
        resendOTPRemainingTime.value = "00:0$seconds";
      }

      if (seconds == 0) {
        enableResendOTP.value = true;
        timer.cancel();
      }
    });
  }

  GlobalKey<FormState> get formKey => _formKey;
  GlobalKey<FormState> get forgotOneFormKey => _forgotOneFormKey;
  GlobalKey<FormState> get forgotTwoFormKey => _forgotTwoFormKey;
  GlobalKey<FormState> get forgotThreeFormKey => _forgotThreeFormKey;
  GlobalKey<FormState> get otpVerificationFormKey => _otpVerificationFormKey;

  @override
  void onClose() {
    switch (_tag) {
      case "signupScreen":
        nameController.dispose();
        mobileController.dispose();
        emailController.dispose();
        pwdController.dispose();
        otpController.dispose();

        _otpVerificationBottomSheetStateSubscription?.cancel();
        _timer?.cancel();
        break;

      case "loginScreen":
        mobileController.dispose();
        pwdController.dispose();
        fMobileController.dispose();
        fOTPController.dispose();
        fPwdController.dispose();
        fCPwdController.dispose();

        _forgotOneBottomSheetStateSubscription?.cancel();
        _forgotTwoBottomSheetStateSubscription?.cancel();
        _forgotThreeBottomSheetStateSubscription?.cancel();

        break;
    }
    super.onClose();
  }
}
