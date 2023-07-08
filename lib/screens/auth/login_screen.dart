import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/custom_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/theme_utils.dart';
import '../../utils/utils.dart';
import '../../widgets/circular_loading_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final double _height = Get.height, _width = Get.width;

  AuthController? _controller;

  OutlineInputBorder _buildOutlineInputBorder({Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(_width * 0.02),
        borderSide: BorderSide(
          color: color ?? HexColor(CustomColors.grey1).withOpacity(0.16),
          width: _height * 0.001,
        ),
      );

  Widget _buildTextFieldWidget(
    TextEditingController controller,
    String hint, {
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: _height * 0.018,
        ),
        validator:
            validator ?? (val) => Utils.notEmptyValidator(val, "Required"),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            color: HexColor(CustomColors.black1),
            fontSize: _height * 0.018,
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
            vertical: _height * 0.021,
            horizontal: _width * 0.04,
          ),
        ),
      );

  Widget get _buildLogInButtonWidget => Obx(
        () => _controller!.loading.value
            ? CircularLoadingWidget(_width, center: true)
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                child: ButtonWidget(
                  text: "Login",
                  onPressed: _controller!.onLoginLoginPressed,
                ),
              ),
      );

  Widget get _buildJoinUsButtonWidget => TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width * 0.02),
          )),
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: _width * 0.015,
              vertical: _height * 0.008,
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(
            HexColor(CustomColors.green1).withOpacity(0.4),
          ),
          foregroundColor: MaterialStateProperty.all(
            HexColor(CustomColors.green1),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.rubik(
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.019,
            ),
          ),
        ),
        onPressed: _controller!.onLoginJoinUsPressed,
        child: const Text(
          "Don't have an account? Join us",
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget get _buildForgotPwdButtonWidget => TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width * 0.025),
          )),
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: _width * 0.02,
              vertical: _height * 0.008,
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(
            HexColor(CustomColors.green1).withOpacity(0.4),
          ),
          foregroundColor: MaterialStateProperty.all(
            HexColor(CustomColors.green1),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.rubik(
              fontWeight: FontWeight.w400,
              fontSize: _height * 0.019,
            ),
          ),
        ),
        onPressed: _controller!.onForgotPasswordPressed,
        child: const Text("Forgot Password"),
      );

  Widget get _buildContentWidget => Column(
        children: [
          Text(
            "Welcome Back",
            style: GoogleFonts.rubik(
              color: Colors.black,
              fontSize: _height * 0.026,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _height * 0.005),
          Text(
            "हमारी सेवा का लाभ उठाने के लिए लॉगिन करें",
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              color: HexColor(CustomColors.grey1),
              fontSize: _height * 0.018,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: _height * 0.1),
          Form(
            key: _controller!.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                _buildTextFieldWidget(
                  _controller!.mobileController,
                  "Mobile",
                  inputType: TextInputType.phone,
                  validator: (val) => Utils.validator2(
                    val,
                    "Required",
                    isMobile: true,
                  ),
                ),
                SizedBox(height: _height * 0.025),
                _buildTextFieldWidget(
                  _controller!.pwdController,
                  "Password",
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: _height * 0.04),
          _buildLogInButtonWidget,
          SizedBox(height: _height * 0.02),
          _buildForgotPwdButtonWidget,
          SizedBox(height: _height * 0.2),
          _buildJoinUsButtonWidget,
        ],
      );

  Widget get _buildForgotThreeContentWidget => Container(
        padding: EdgeInsets.only(
          bottom: _height * 0.025,
          top: _height * 0.022,
          left: _width * 0.05,
          right: _width * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: _height * 0.007,
                width: _width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_width),
                  color: HexColor(CustomColors.grey6),
                ),
              ),
            ),
            SizedBox(height: _height * 0.06),
            Text(
              "Reset Password",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.023,
              ),
            ),
            SizedBox(height: _height * 0.012),
            Text(
              "Set the new password for your account so you can login and access all the features.",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w400,
                fontSize: _height * 0.016,
                color: HexColor(CustomColors.grey1),
              ),
            ),
            SizedBox(height: _height * 0.03),
            Form(
              key: _controller!.forgotThreeFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  _buildTextFieldWidget(
                    _controller!.fPwdController,
                    "New Password",
                  ),
                  SizedBox(height: _height * 0.02),
                  _buildTextFieldWidget(
                    _controller!.fCPwdController,
                    "Re-enter Password",
                    validator: (val) => Utils.validator2(
                      val,
                      "required",
                      val2: _controller!.fPwdController.text,
                      matchTwoValues: true,
                      message2: "Password & Confirm password does not match",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
              child: Obx(
                () => _controller!.fThreeLoading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : ButtonWidget(
                        text: "Update Password",
                        onPressed: _controller!.onForgotUpdatePasswordPressed,
                      ),
              ),
            ),
          ],
        ),
      );

  Widget get _buildForgotTwoContentWidget => Container(
        padding: EdgeInsets.only(
          bottom: _height * 0.025,
          top: _height * 0.022,
          left: _width * 0.05,
          right: _width * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: _height * 0.007,
                width: _width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_width),
                  color: HexColor(CustomColors.grey6),
                ),
              ),
            ),
            SizedBox(height: _height * 0.06),
            Text(
              "Enter 4 Digits Code",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.023,
              ),
            ),
            SizedBox(height: _height * 0.012),
            Text(
              "Enter the 4 digits code that you received on your mobile.",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w400,
                fontSize: _height * 0.018,
                color: HexColor(CustomColors.grey1),
              ),
            ),
            SizedBox(height: _height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
              child: Form(
                key: _controller!.forgotTwoFormKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: _buildPinFieldWidget,
              ),
            ),
            SizedBox(height: _height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
              child: Obx(
                () => _controller!.fTwoLoading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : ButtonWidget(
                        text: "Continue",
                        onPressed: _controller!.onForgotTwoContinuePressed,
                      ),
              ),
            ),
          ],
        ),
      );

  Widget get _buildForgotOneContentWidget => Container(
        padding: EdgeInsets.only(
          bottom: _height * 0.025,
          top: _height * 0.022,
          left: _width * 0.05,
          right: _width * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: _height * 0.007,
                width: _width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_width),
                  color: HexColor(CustomColors.grey6),
                ),
              ),
            ),
            SizedBox(height: _height * 0.06),
            Text(
              "Forgot Password",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.023,
              ),
            ),
            SizedBox(height: _height * 0.012),
            Text(
              "Enter your mobile number for the verification proccesss, we will send 4 digits code.",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w400,
                fontSize: _height * 0.018,
                color: HexColor(CustomColors.grey1),
              ),
            ),
            SizedBox(height: _height * 0.03),
            Form(
              key: _controller!.forgotOneFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: _buildTextFieldWidget(
                _controller!.fMobileController,
                "Mobile Number",
              ),
            ),
            SizedBox(height: _height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
              child: Obx(
                () => _controller!.fOneLoading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : ButtonWidget(
                        text: "Continue",
                        onPressed: _controller!.onForgotOneContinuePressed,
                      ),
              ),
            ),
          ],
        ),
      );

  Future<void> _showForgotBottomSheet(Widget content) async {
    return showMaterialModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_height * 0.015),
          topRight: Radius.circular(_height * 0.015),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: Get.mediaQuery.viewInsets.bottom +
                Get.mediaQuery.padding.bottom,
            top: Get.mediaQuery.viewInsets.top,
          ),
          child: content,
        );
      },
    );
  }

  Widget get _buildPinFieldWidget => SizedBox(
        width: double.infinity,
        child: LayoutBuilder(builder: (context, cons) {
          return PinCodeTextField(
            controller: _controller!.fOTPController,
            appContext: Get.context!,
            length: 4,
            obscureText: true,
            animationType: AnimationType.fade,
            autoDismissKeyboard: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            validator: (val) => Utils.validator2(
              val,
              "Required",
              isOTP: true,
              otpLength: 4,
            ),
            autoDisposeControllers: false,
            pinTheme: PinTheme(
              borderRadius: BorderRadius.circular(_width * 0.025),
              shape: PinCodeFieldShape.box,
              fieldHeight: cons.maxWidth * 0.21,
              fieldWidth: cons.maxWidth * 0.2,
              activeFillColor: Colors.transparent,
              activeColor: HexColor(CustomColors.grey1).withOpacity(0.16),
              inactiveColor: HexColor(CustomColors.grey1).withOpacity(0.16),
              disabledColor: HexColor(CustomColors.grey1).withOpacity(0.16),
              selectedColor: HexColor(CustomColors.blue1),
              errorBorderColor: Colors.red,
              borderWidth: _height * 0.001,
              inactiveFillColor: Colors.transparent,
              selectedFillColor: Colors.transparent,
            ),
            cursorHeight: cons.maxWidth * 0.1,
            textStyle: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: _height * 0.018,
            ),
            hintStyle: GoogleFonts.rubik(
              fontWeight: FontWeight.w400,
              color: HexColor(CustomColors.black1),
              fontSize: _height * 0.018,
            ),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            onCompleted: (v) {},
            onChanged: (value) {},
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = Get.find<AuthController>(tag: "loginScreen");

      _controller!.listenForgotOneBottomSheetState(
        () => _showForgotBottomSheet(_buildForgotOneContentWidget),
      );

      _controller!.listenForgotTwoBottomSheetState(
        () => _showForgotBottomSheet(_buildForgotTwoContentWidget),
      );

      _controller!.listenForgotThreeBottomSheetState(
        () => _showForgotBottomSheet(_buildForgotThreeContentWidget),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            top: MediaQuery.of(context).padding.top,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
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
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: _height * 0.25,
                  width: _height * 0.25,
                  child: Image.asset(
                    "assets/images/common_blue_artwork.webp",
                    height: _height * 0.25,
                    width: _height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(
                  top: _height * 0.12,
                  left: _width * 0.06,
                  right: _width * 0.06,
                ),
                child: _buildContentWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
