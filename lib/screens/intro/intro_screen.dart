import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/constants/custom_colors.dart';
import 'package:flutter_hello_my_doctor/controllers/intro_page_view_controller.dart';
import 'package:flutter_hello_my_doctor/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class IntroScreen extends StatelessWidget {
  final String _title, _desc, _artworkPath;
  final bool reverseTopGradient;

  IntroScreen(this._title, this._desc, this._artworkPath,
      {Key? key, this.reverseTopGradient = false})
      : super(key: key);

  final double _height = Get.height, _width = Get.width;

  IntroPageViewController? _introPageViewController;

  Widget get _buildSkipButtonWidget => TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_width * 0.02),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 0)),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: _width * 0.015,
              vertical: _height * 0.0185,
            ),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: MaterialStatePropertyAll(
            HexColor(CustomColors.grey1),
          ),
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.rubik(
              fontSize: _height * 0.018,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onPressed: _introPageViewController!.onSkipPressed,
        child: const Text(
          "Skip",
          overflow: TextOverflow.ellipsis,
        ),
      );

  @override
  Widget build(BuildContext context) {
    _introPageViewController ??= Get.find<IntroPageViewController>();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: -_height * 0.04,
              right: reverseTopGradient ? -_width * 0.28 : null,
              left: !reverseTopGradient ? -_width * 0.28 : null,
              child: Container(
                height: _height * 0.39,
                width: _height * 0.39,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      HexColor(CustomColors.blue2),
                      HexColor(CustomColors.blue3),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: _height * 0.1),
                child: SizedBox(
                  height: _height * 0.38,
                  width: _height * 0.38,
                  child: Image.asset(
                    _artworkPath,
                    height: _height * 0.38,
                    width: _height * 0.38,
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
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: _height * 0.15),
                  Text(
                    _title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: _height * 0.025,
                      color: HexColor(CustomColors.black1),
                    ),
                  ),
                  SizedBox(height: _height * 0.013),
                  Text(
                    _desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: _height * 0.016,
                      fontWeight: FontWeight.w400,
                      color: HexColor(CustomColors.grey1).withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: _height * 0.07),
                  ButtonWidget(
                    text: "Get Started",
                    onPressed: _introPageViewController!.onGetStartedPressed,
                  ),
                  SizedBox(height: _height * 0.01),
                  _buildSkipButtonWidget,
                  SizedBox(height: _height * 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
