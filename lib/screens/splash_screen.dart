import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import '../utils/theme_utils.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final double _height = Get.height, _width = Get.width;

  SplashController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<SplashController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: _height,
              width: _width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/splash_artwork.webp",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.only(
                // top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: _height * 0.18,
                  width: _height * 0.18,
                  child: Image.asset("assets/images/logo.webp"),
                ),
                SizedBox(height: _height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
                  child: ButtonWidget(
                    text: "Get Started",
                    onPressed: _controller!.onGetStartedPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
