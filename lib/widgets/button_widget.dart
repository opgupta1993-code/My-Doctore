import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';

class ButtonWidget extends StatelessWidget {
  final double _height = Get.height, _width = Get.width;

  final String text;
  final VoidCallback onPressed;

  ButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
        backgroundColor: MaterialStatePropertyAll(
          HexColor(CustomColors.blue1),
        ),
        overlayColor: MaterialStatePropertyAll(
          Colors.white.withOpacity(0.4),
        ),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.rubik(
            fontSize: _height * 0.02,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
