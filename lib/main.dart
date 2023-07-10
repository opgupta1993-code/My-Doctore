import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/models/city_model.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/select_city_controller.dart';
import 'controllers/user_controller.dart';
import 'models/user_model.dart';
import 'routes/routes.dart';
import 'utils/firebase_notifications.dart';
import 'utils/shared_preferences_util.dart';
import 'utils/theme_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _dependencyInjection();

  try {
    await Firebase.initializeApp();
    await FirebaseNotifications.setupFCMListener();

    final bool value = await Permission.notification.isDenied;

    if (value) {
      Permission.notification.request();
    }
  } catch (err) {
    //print("ERROR :: main :: $err");
  }

  runApp(const MyApp());
}

Future<void> _dependencyInjection() async {
  final UserController userController = UserController();

  final SharedPreferences preferences =
      await SharedPreferencesUtil.getSharedPreferences();

  userController.setIsIntroCompleted = preferences.containsKey("intro") &&
      preferences.getBool("intro") != null &&
      preferences.getBool("intro")!;

  userController.setIsLogin = preferences.containsKey("login") &&
      preferences.getBool("login") != null &&
      preferences.getBool("login")!;

  if (userController.isLogin.value) {
    final String userDataString = preferences.getString("userData") ?? "{}";
    final Map userData = jsonDecode(userDataString);

    print("userDataString --> $userDataString");

    userController.setUser = UserModel.fromJson(userData);
  }

  Get.put(preferences, permanent: true);
  Get.put(userController, permanent: true);
  Get.put(SelectCityController(), permanent: true);

  if (userController.isLogin.value) {
    final SelectCityController selectCityController = Get.find();

    final bool isCitySelected = preferences.containsKey("isCitySelected") &&
        (preferences.getBool("isCitySelected") ?? false);

    if (isCitySelected) {
      final String selectCityString =
          preferences.getString("selectedCity") ?? "{}";
      final Map selectedCityData = jsonDecode(selectCityString);

      selectCityController.onCitySelected(
        CityModel.fromJson(selectedCityData),
        navigateFurther: false,
      );
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        const AssetImage("assets/images/splash_artwork.webp"), context);
    precacheImage(const AssetImage("assets/images/logo.webp"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    SelectCityController? selectCityController;

    if (Get.isRegistered<SelectCityController>()) {
      selectCityController = Get.find<SelectCityController>();
    }

    // final DateTime dateTime = DateTime.now();

    // if (dateTime.isAfter(DateTime(2023, 7, 12))) {
    //   Utils.showToast("APK EXPIRED");
    //   if (Platform.isAndroid) {
    //     SystemNavigator.pop();
    //   } else if (Platform.isIOS) {
    //     exit(0);
    //   }
    // }

    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Hello My Doctor",
      theme: ThemeUtils.lightTheme,
      darkTheme: ThemeUtils.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: !userController.isLogin.value
          ? "/splashScreen"
          : selectCityController?.selectedCity != null
              ? "/drawerScreen"
              : "/selectCityScreen",
      popGesture: true,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 450),
      getPages: Routes.getPages,
    );
  }
}
