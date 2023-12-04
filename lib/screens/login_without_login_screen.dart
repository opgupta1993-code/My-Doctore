import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/login_without_login_controller.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';

// ignore: must_be_immutable
class LoginWithoutLoginScreen extends StatelessWidget {
  LoginWithoutLoginScreen({Key? key}) : super(key: key);

  final double _height = Get.height, _width = Get.width;

  LoginWithoutLoginController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<LoginWithoutLoginController>();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: -_height * 0.04,
              left: -_width * 0.28,
              child: Container(
                height: _height * 0.39,
                width: _height * 0.39,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      HexColor(CustomColors.blue2),
                      HexColor(CustomColors.blue1),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: _height * 0.1),
                child: SizedBox(
                  height: _height * 0.25,
                  width: _height * 0.25,
                  child: Image.asset(
                    "assets/images/common_green_artwork.webp",
                    height: _height * 0.25,
                    width: _height * 0.25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    text: "Continue With Login",
                    onPressed: () => _controller!.onButtonPressed(0),
                  ),
                  SizedBox(height: _height * 0.035),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: HexColor(CustomColors.grey2),
                          thickness: _height * 0.001,
                          height: _height * 0.001,
                        ),
                      ),
                      SizedBox(width: _width * 0.02),
                      Text(
                        "or",
                        style: Theme.of(Get.context!)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: _height * 0.02,
                              color: HexColor(CustomColors.grey2),
                            ),
                      ),
                      SizedBox(width: _width * 0.02),
                      Expanded(
                        child: Divider(
                          color: HexColor(CustomColors.grey2),
                          thickness: _height * 0.001,
                          height: _height * 0.001,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _height * 0.035),
                  ButtonWidget(
                    text: "Continue Without Login",
                    onPressed: () => _controller!.onButtonPressed(1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
