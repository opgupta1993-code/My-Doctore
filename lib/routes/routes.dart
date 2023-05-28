import 'package:flutter_hello_my_doctor/bindings/auth_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/drawer_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/login_without_login_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/select_doctor_category_binding.dart';
import 'package:flutter_hello_my_doctor/screens/auth/login_screen.dart';
import 'package:flutter_hello_my_doctor/screens/auth/signup_screen.dart';
import 'package:flutter_hello_my_doctor/screens/drawer/drawer_screen.dart';
import 'package:flutter_hello_my_doctor/screens/login_without_login_screen.dart';
import 'package:flutter_hello_my_doctor/screens/select_doctor_category_screen.dart';
import 'package:get/get.dart';

import '../bindings/intro_page_view_binding.dart';
import '../bindings/splash_binding.dart';
import '../screens/intro/intro_page_view_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static final List<GetPage<dynamic>> getPages = [
    GetPage(
      name: "/splashScreen",
      page: () => SplashScreen(),
      popGesture: true,
      binding: SplashBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/introPageViewScreen",
      page: () => IntroPageViewScreen(),
      popGesture: true,
      binding: IntroPageViewBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/loginWithoutLoginScreen",
      page: () => LoginWithoutLoginScreen(),
      popGesture: true,
      binding: LoginWithoutLoginBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/loginScreen",
      page: () => LoginScreen(),
      popGesture: true,
      binding: AuthBinding("loginScreen"),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/signupScreen",
      page: () => SignupScreen(),
      popGesture: true,
      binding: AuthBinding("signupScreen"),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/drawerScreen",
      page: () => DrawerScreen(),
      popGesture: true,
      binding: DrawerBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/selectDoctorCategoryScreen",
      page: () => SelectDoctorCategoryScreen(),
      popGesture: true,
      binding: SelectDoctorCategoryBinding(),
      showCupertinoParallax: true,
    ),
  ];

  static Future<void> splashScreen() async {
    return await Get.toNamed("/splashScreen");
  }

  static Future<void> introPageViewScreen() async {
    return await Get.offAllNamed("/introPageViewScreen");
  }

  static Future<void> loginScreen() async {
    return await Get.toNamed("/loginScreen");
  }

  static Future<void> signupScreen() async {
    return await Get.toNamed("/signupScreen");
  }

  static Future<void> loginWithoutLoginScreen() async {
    return await Get.offAllNamed("/loginWithoutLoginScreen");
  }

  static Future<void> drawerScreen() async {
    return await Get.offAllNamed("/drawerScreen");
  }

  static Future<void> selectDoctorCategoryScreen() async {
    return await Get.toNamed("/selectDoctorCategoryScreen");
  }
}
