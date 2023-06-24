import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../routes/routes.dart';

class Utils {
  static void removeFocus({BuildContext? context}) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String? notEmptyValidator(val, String message) {
    if (val.toString().trim().isEmpty) {
      return message;
    }

    return null;
  }

  static String? validator2(
    val,
    String message, {
    bool isPwd = false,
    bool isMobile = false,
    bool isPinCode = false,
    bool isOTP = false,
    int otpLength = 4,
    bool isEmail = false,
    bool matchTwoValues = false,
    String val2 = "",
    String? message2,
  }) {
    if (val.toString().trim().isEmpty) {
      return message;
    }

    if (isPwd) {
      return _isPasswordValid(val);
    }

    if (isMobile && val.toString().trim().length != 10) {
      return "Invalid Phone Number!";
    }

    if (isPinCode && val.toString().trim().length != 6) {
      return "Invalid Pin Code!";
    }

    if (isOTP && val.toString().trim().length != otpLength) {
      return "Invalid OTP!";
    }

    if (isEmail && !val.toString().trim().isEmail) {
      return "Invalid Email!";
    }

    if (matchTwoValues && val2.toString().trim().isNotEmpty && val != val2) {
      // matching two values || example : Pwd & Confirm Pwd
      return message2 ?? "Does not match";
    }

    return null;
  }

  static String? _isPasswordValid(String password) {
    if (password.length < 8) {
      return "Should be 8 characters long";
    }
    if (!password.contains(RegExp(r"[a-z]"))) {
      return "At least 1 small alphabet is required";
    }
    if (!password.contains(RegExp(r"[A-Z]"))) {
      return "At least 1 capital alphabet is required";
    }
    if (!password.contains(RegExp(r"[0-9]"))) {
      return "At least 1 numeric character is required";
    }
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "At least 1 special character is required";
    // }
    return null;
  }

  static void showToast(String msg, {Color color = Colors.red}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: Get.height * 0.02,
    );
  }

  static double getDoubleFromString(
    String data, {
    int decimalPlaces = 1,
  }) {
    return double.parse(
      ((double.tryParse(data) ?? int.tryParse(data) ?? 0))
          .toStringAsFixed(decimalPlaces),
    );
  }

  static int getIntFromString(String data) {
    return (double.tryParse(data) ?? int.tryParse(data) ?? 0).toInt();
  }

  static String getTomorrowDayName() {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = now.add(const Duration(days: 1));

    final DateFormat formatter =
        DateFormat.EEEE(); // EEEE gives the full day name
    final String dayName = formatter.format(tomorrow);

    return dayName;
  }

  static String getAmPmOfTime(String time) {
    final DateFormat formatter = DateFormat.jm();
    final DateTime dateTime = DateFormat.Hm().parse(time);
    final String amPm = formatter.format(dateTime);

    return amPm;
  }

  static String convertTo12HourFormat(String time) {
    final DateFormat formatter = DateFormat('h:mm');
    final DateTime dateTime = DateFormat.Hm().parse(time);
    final String formattedTime = formatter.format(dateTime);

    return formattedTime;
  }

  static Future<void> logout() async {
    final SharedPreferences preferences = Get.find();
    final UserController userController = Get.find();

    await preferences.remove("login");
    await preferences.remove("userData");
    Routes.loginWithoutLoginScreen();

    await Future.delayed(const Duration(milliseconds: 300));

    userController.setIsLogin = false;
    userController.setUser = UserModel();
  }

  static Future<void> openUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (err) {
      //print("ERROR :: Utils :: openUrl :: $url");
    }
  }
}
