import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/controllers/profile_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  UserController? _userController;
  ProfileController? _controller;

  PreferredSizeWidget get _buildAppbarWidget => PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Container(
          height: AppBar().preferredSize.height + Get.mediaQuery.padding.top,
          color: HexColor(CustomColors.blue1),
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top,
            left: _width * 0.02,
            right: _width * 0.02,
          ),
          alignment: Alignment.center,
          child: LayoutBuilder(builder: (context, cons) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackButtonWidget(),
                SizedBox(width: _width * 0.03),
                Expanded(
                  child: Text(
                    "Profile",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: cons.maxHeight * 0.32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );

  Widget get _buildTopWidget => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor(CustomColors.blue1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_width * 0.07),
            bottomRight: Radius.circular(_width * 0.07),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.05,
          vertical: _height * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Set up your profile",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: _height * 0.018,
              ),
            ),
            SizedBox(height: _height * 0.01),
            Text(
              "Update your profile to connect your doctor with better impression.",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: _height * 0.016,
              ),
            ),
            SizedBox(height: _height * 0.035),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: _height * 0.007,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    foregroundImage: CachedNetworkImageProvider(
                      _userController!.user.value.userImg,
                    ),
                    child: _userController!.user.value.userImg.isEmpty
                        ? _userController!.user.value.userName.isNotEmpty
                            ? Text(
                                _userController!.user.value.userName[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: _height * 0.018,
                                ),
                              )
                            : null
                        : null,
                  ),
                ),
                Positioned(
                  right: -_width * 0.01,
                  bottom: _height * 0.015,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor(CustomColors.grey1).withOpacity(0.8),
                    ),
                    padding: EdgeInsets.all(_width * 0.02),
                    child: Icon(
                      CupertinoIcons.camera_fill,
                      size: _height * 0.02,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Widget _buildInfoWidget(String title, String data) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_width * 0.025),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.035,
          vertical: _height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.0165,
                color: HexColor(CustomColors.green1),
              ),
            ),
            SizedBox(height: _height * 0.008),
            Text(
              data,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w300,
                fontSize: _height * 0.019,
                color: HexColor(CustomColors.grey1),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _userController ??= Get.find<UserController>();
    _controller ??= Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarOneTheme(context),
      child: Scaffold(
        appBar: _buildAppbarWidget,
        body: Padding(
          padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopWidget,
                SizedBox(height: _height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal information",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: _height * 0.02,
                        ),
                      ),
                      SizedBox(height: _height * 0.025),
                      Obx(
                        () => _buildInfoWidget(
                          "Name",
                          _userController!.user.value.userName,
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      Obx(
                        () => _buildInfoWidget(
                          "Contact Number",
                          _userController!.user.value.mobileNo,
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      Obx(
                        () => _buildInfoWidget(
                          "Date of birth",
                          _userController!.user.value.dob,
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      Obx(
                        () => _buildInfoWidget(
                          "Location",
                          _userController!.user.value.address,
                        ),
                      ),
                      SizedBox(height: _height * 0.05),
                      ButtonWidget(
                        text: "Update Profile",
                        onPressed: _controller!.onUpdatePressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
