import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:flutter_hello_my_doctor/widgets/circular_loading_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';
import '../controllers/edit_profile_controller.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  EditProfileController? _controller;

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
                    "Edit Profile",
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

  OutlineInputBorder _buildOutlineInputBorder({Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(_width * 0.035),
        borderSide: BorderSide(
          color: color ?? HexColor(CustomColors.grey1).withOpacity(0.16),
          width: _height * 0.001,
        ),
      );

  Widget _buildTextFieldWidget(
    TextEditingController controller,
    String hint, {
    bool obscureText = false,
    bool enabled = true,
    TextInputType inputType = TextInputType.emailAddress,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: _height * 0.017,
        ),
        validator:
            validator ?? (val) => Utils.notEmptyValidator(val, "Required"),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w300,
            color: HexColor(CustomColors.grey1),
            fontSize: _height * 0.017,
          ),
          border: _buildOutlineInputBorder(),
          disabledBorder: _buildOutlineInputBorder(),
          enabledBorder: _buildOutlineInputBorder(),
          focusedBorder: _buildOutlineInputBorder(
            color: HexColor(CustomColors.blue1),
          ),
          errorBorder: _buildOutlineInputBorder(color: Colors.red),
          focusedErrorBorder: _buildOutlineInputBorder(color: Colors.red),
          contentPadding: EdgeInsets.symmetric(
            vertical: _height * 0.015,
            horizontal: _width * 0.04,
          ),
        ),
      );

  Widget _buildDatePickerWidget(
    TextEditingController controller,
    String hint,
  ) =>
      GestureDetector(
        onTap: _controller!.openDatePicker,
        child: AbsorbPointer(
          absorbing: true,
          child: _buildTextFieldWidget(
            controller,
            hint,
            enabled: true,
          ),
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
            GestureDetector(
              onTap: _controller!.selectImage,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: _height * 0.07,
                      foregroundImage: FileImage(
                        File(_controller!.imagePath.value),
                      ),
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
            ),
          ],
        ),
      );

  Future<int?> _showImageSourceBottomSheet() async {
    return showModalBottomSheet<int?>(
      context: Get.context!,
      backgroundColor: Get.isDarkMode
          ? HexColor(CustomColors.black1)
          : Get.theme.scaffoldBackgroundColor,
      barrierColor: Colors.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_height * 0.015),
          topRight: Radius.circular(_height * 0.015),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                    alignment: Alignment.center,
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: _height * 0.02,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    return Get.back(result: 2);
                  },
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                    alignment: Alignment.center,
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: _height * 0.02,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    return Get.back(result: 1);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = Get.find<EditProfileController>();
      _controller!.listenImageBottomSheetState(_showImageSourceBottomSheet);
    }

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
                      Form(
                        key: _controller!.fKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            _buildTextFieldWidget(
                              _controller!.nameController,
                              "Name",
                            ),
                            SizedBox(height: _height * 0.02),
                            _buildTextFieldWidget(
                              _controller!.mobileController,
                              "Contact Number",
                            ),
                            SizedBox(height: _height * 0.02),
                            _buildDatePickerWidget(
                              _controller!.dobController,
                              "Date of Birth",
                            ),
                            SizedBox(height: _height * 0.02),
                            _buildTextFieldWidget(
                              _controller!.locationController,
                              "Location",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _height * 0.04),
                      Obx(
                        () => _controller!.loading.value
                            ? CircularLoadingWidget(_width, center: true)
                            : ButtonWidget(
                                text: "Update Profile",
                                onPressed: _controller!.onUpdatePressed,
                              ),
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
