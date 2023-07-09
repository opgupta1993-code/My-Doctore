import 'package:flutter_hello_my_doctor/bindings/appointments_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/auth_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/doctor_details_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/drawer_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/edit_profile_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/login_without_login_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/make_appointment_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/notifications_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/profile_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/select_city_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/select_doctor_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/select_doctor_category_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/video_review_binding.dart';
import 'package:flutter_hello_my_doctor/bindings/webview_binding.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/screens/auth/login_screen.dart';
import 'package:flutter_hello_my_doctor/screens/auth/signup_screen.dart';
import 'package:flutter_hello_my_doctor/screens/doctor_details_screen.dart';
import 'package:flutter_hello_my_doctor/screens/drawer/appointments_screen.dart';
import 'package:flutter_hello_my_doctor/screens/drawer/drawer_screen.dart';
import 'package:flutter_hello_my_doctor/screens/drawer/notifications_screen.dart';
import 'package:flutter_hello_my_doctor/screens/drawer/profile_screen.dart';
import 'package:flutter_hello_my_doctor/screens/edit_profile_screen.dart';
import 'package:flutter_hello_my_doctor/screens/login_without_login_screen.dart';
import 'package:flutter_hello_my_doctor/screens/make_appointment_screen.dart';
import 'package:flutter_hello_my_doctor/screens/select_city_screen.dart';
import 'package:flutter_hello_my_doctor/screens/select_doctor_category_screen.dart';
import 'package:flutter_hello_my_doctor/screens/select_doctor_screen.dart';
import 'package:flutter_hello_my_doctor/screens/video_review_screen.dart';
import 'package:flutter_hello_my_doctor/screens/webview_screen.dart';
import 'package:get/get.dart';

import '../bindings/intro_page_view_binding.dart';
import '../bindings/splash_binding.dart';
import '../screens/drawer/coming_soon_screen.dart';
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
    GetPage(
      name: "/selectCityScreen",
      page: () => SelectCityScreen(),
      popGesture: true,
      binding: SelectCityBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/selectDoctorScreen",
      page: () => SelectDoctorScreen(),
      popGesture: true,
      binding: SelectDoctorBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/makeAppointmentScreen",
      page: () => MakeAppointmentScreen(),
      popGesture: true,
      binding: MakeAppointmentBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/doctorDetailsScreen",
      page: () => DoctorDetailsScreen(),
      popGesture: true,
      binding: DoctorDetailsBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/profileScreen",
      page: () => ProfileScreen(),
      popGesture: true,
      binding: ProfileBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/comingSoonScreen",
      page: () => ComingSoonScreen(),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/editProfileScreen",
      page: () => EditProfileScreen(),
      popGesture: true,
      binding: EditProfileBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/appointmentsScreen",
      page: () => AppointmentsScreen(),
      popGesture: true,
      binding: AppointmentsBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/notificationsScreen",
      page: () => NotificationsScreen(),
      popGesture: true,
      binding: NotificationsBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/videoReviewScreen",
      page: () => VideoReviewScreen(),
      popGesture: true,
      binding: VideoReviewBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/webviewScreen",
      page: () => WebviewScreen(),
      popGesture: true,
      binding: WebviewBinding(),
      showCupertinoParallax: true,
    ),
  ];

  static Future<void> splashScreen() async {
    return await Get.toNamed("/splashScreen");
  }

  static Future<void> introPageViewScreen() async {
    return await Get.offAllNamed("/introPageViewScreen");
  }

  static Future<void> loginScreen({
    bool isDirectLogin = true,
    String? previousRoute,
  }) async {
    return await Get.toNamed(
      "/loginScreen",
      arguments: {
        "isDirectLogin": isDirectLogin,
        "previousRoute": previousRoute,
      },
    );
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

  static Future<void> selectCityScreen({bool afterLogin = false}) async {
    if (afterLogin) {
      return await Get.offAllNamed(
        "/selectCityScreen",
        arguments: {"data": afterLogin},
      );
    }

    return await Get.toNamed(
      "/selectCityScreen",
      arguments: {"data": afterLogin},
    );
  }

  static Future<void> selectDoctorScreen() async {
    return await Get.toNamed("/selectDoctorScreen");
  }

  static Future<void> makeAppointmentScreen(DoctorDetailsModel data) async {
    return await Get.toNamed(
      "/makeAppointmentScreen",
      arguments: {"data": data},
    );
  }

  static Future<void> doctorDetailsScreen(String id) async {
    return await Get.toNamed(
      "/doctorDetailsScreen",
      arguments: {"data": id},
    );
  }

  static Future<void> profileScreen() async {
    return await Get.toNamed("/profileScreen");
  }

  static Future<void> comingSoonScreen(String data) async {
    return await Get.toNamed("/comingSoonScreen", arguments: {"data": data});
  }

  static Future<void> editProfileScreen() async {
    return await Get.toNamed("/editProfileScreen");
  }

  static Future<void> appointmentsScreen() async {
    return await Get.toNamed("/appointmentsScreen");
  }

  static Future<void> notificationsScreen() async {
    return await Get.toNamed("/notificationsScreen");
  }

  static Future<void> videoReviewScreen(String url) async {
    return await Get.toNamed(
      "/videoReviewScreen",
      arguments: {"data": url},
    );
  }

  static Future<void> webviewScreen(String url) async {
    return await Get.toNamed(
      "/webviewScreen",
      arguments: {"url": url},
    );
  }
}
