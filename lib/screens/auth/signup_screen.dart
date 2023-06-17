import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/custom_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/theme_utils.dart';
import '../../utils/utils.dart';
import '../../widgets/circular_loading_widget.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

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
    TextInputType inputType = TextInputType.emailAddress,
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

  Widget get _buildSignUpButtonWidget => Obx(
        () => _controller!.loading.value
            ? CircularLoadingWidget(_width, center: true)
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                child: ButtonWidget(
                  text: "Sign up",
                  onPressed: _controller!.onSignupSignupPressed,
                ),
              ),
      );

  Widget get _buildLogInButtonWidget => TextButton(
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
        onPressed: _controller!.onSignupLoginPressed,
        child: const Text(
          "Have an account? Log in",
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget get _buildContentWidget => Column(
        children: [
          Text(
            "Join us to start searching",
            style: GoogleFonts.rubik(
              color: Colors.black,
              fontSize: _height * 0.026,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _height * 0.005),
          Text(
            "You can search course, apply course and find scholarship for abroad studies",
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              color: HexColor(CustomColors.grey1),
              fontSize: _height * 0.016,
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
                  _controller!.nameController,
                  "Name",
                ),
                SizedBox(height: _height * 0.025),
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
                // SizedBox(height: _height * 0.025),
                // _buildTextFieldWidget(
                //   _controller!.emailController,
                //   "Email",
                //   validator: (val) => Utils.validator2(
                //     val,
                //     "Required",
                //     isEmail: true,
                //   ),
                // ),
                SizedBox(height: _height * 0.025),
                _buildTextFieldWidget(
                  _controller!.pwdController,
                  "Password",
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: _height * 0.015),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Checkbox(
                  value: _controller!.agree.value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const CircleBorder(),
                  onChanged: (val) => _controller!.onAgreePressed(),
                ),
              ),
              Expanded(
                child: Text(
                  "I agree with the Terms of Service & Privacy Policy",
                  style: GoogleFonts.rubik(
                    color: HexColor(CustomColors.grey1),
                    fontWeight: FontWeight.w400,
                    fontSize: _height * 0.016,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _height * 0.04),
          _buildSignUpButtonWidget,
          SizedBox(height: _height * 0.16),
          _buildLogInButtonWidget
        ],
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<AuthController>(tag: "signupScreen");

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
