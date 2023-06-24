import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/constants/custom_colors.dart';
import 'package:flutter_hello_my_doctor/controllers/drawer_controller.dart'
    as dc;
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/theme_utils.dart';
import '../../widgets/profile_button_widget.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);
  final double _height = Get.height, _width = Get.width;

  UserController? _userController;
  dc.DrawerController? _controller;

  Widget _buildDrawerItemButtonWidget(
    int type,
    String title,
    String iconPath, {
    bool showTrailingIcon = true,
  }) =>
      TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width * 0.015),
          )),
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 0),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: _width * 0.015,
              vertical: _height * 0.025,
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.019,
            ),
          ),
        ),
        onPressed: () => _controller!.onDrawerItemPressed(type),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: _height * 0.025,
              width: _height * 0.025,
              child: Image.asset(iconPath),
            ),
            SizedBox(width: _width * 0.04),
            Expanded(child: Text(title)),
            if (showTrailingIcon)
              Row(
                children: [
                  SizedBox(width: _width * 0.015),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: _height * 0.018,
                  ),
                ],
              )
          ],
        ),
      );

  Widget get _buildDrawerTopWidget => Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(_width * 0.025),
            onTap: _controller!.onProfilePressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileButtonWidget(
                  radius: _height * 0.031,
                  onPressed: _controller!.onProfilePressed,
                ),
                SizedBox(width: _width * 0.025),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userController!.user.value.userName,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: _height * 0.0185,
                            ),
                      ),
                      SizedBox(height: _height * 0.005),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: _height * 0.018,
                            color: Colors.white,
                          ),
                          SizedBox(width: _width * 0.01),
                          Text(
                            _userController!.user.value.mobileNo,
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: _height * 0.017,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _height * 0.04,
          ),
        ],
      );

  Widget get _buildDrawerWidget => Drawer(
        backgroundColor: HexColor(CustomColors.grey3),
        child: Padding(
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top,
            bottom: Get.mediaQuery.padding.bottom,
            left: _width * 0.04,
            right: _width * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(height: _height * 0.015),
              Obx(
                () => _userController!.isLogin.value
                    ? _buildDrawerTopWidget
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildDrawerItemButtonWidget(
                        0,
                        "Change Location",
                        "assets/images/location.webp",
                      ),
                      Obx(
                        () => _userController!.isLogin.value
                            ? _buildDrawerItemButtonWidget(
                                1,
                                "Appointments",
                                "assets/images/test_bookings.webp",
                              )
                            : const SizedBox.shrink(),
                      ),
                      _buildDrawerItemButtonWidget(
                        2,
                        "Medicine",
                        "assets/images/test_bookings.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        3,
                        "Pathology",
                        "assets/images/test_bookings.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        4,
                        "Covid-19 RT-PCR",
                        "assets/images/test_bookings.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        5,
                        "Notifications",
                        "assets/images/test_bookings.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        6,
                        "Terms & Conditions",
                        "assets/images/privacy_policy.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        7,
                        "Privacy & Policy",
                        "assets/images/privacy_policy.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        8,
                        "Refund Policy",
                        "assets/images/privacy_policy.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        9,
                        "Help Center",
                        "assets/images/help_center.webp",
                      ),
                      _buildDrawerItemButtonWidget(
                        10,
                        "Settings",
                        "assets/images/settings.webp",
                      ),
                      Obx(
                        () => _userController!.isLogin.value
                            ? Column(
                                children: [
                                  SizedBox(height: _height * 0.04),
                                  _buildDrawerItemButtonWidget(
                                    11,
                                    "Logout",
                                    "assets/images/logout.webp",
                                    showTrailingIcon: false,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _userController ??= Get.find<UserController>();
    _controller ??= Get.find<dc.DrawerController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        key: _controller!.sfKey,
        body: Padding(
          padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
          child: HomeScreen(),
        ),
        drawer: _buildDrawerWidget,
      ),
    );
  }
}
