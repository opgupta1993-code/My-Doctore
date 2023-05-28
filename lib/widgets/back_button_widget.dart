import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  final double _height = Get.height, _width = Get.width;

  final Color? iconColor;
  final Color overlayColor;
  final IconData iconData;

  final VoidCallback? onPressed;

  BackButtonWidget({
    Key? key,
    this.iconColor,
    this.overlayColor = Colors.white,
    // this.iconData = Icons.keyboard_backspace,
    this.iconData = CupertinoIcons.chevron_back,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;

    if (iconColor != null) {
      color = iconColor!;
    } else {
      color = Colors.black;
    }

    return ElevatedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width*0.02),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(_width * 0.01),
        ),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(
          overlayColor.withOpacity(0.3),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(color),
      ),
      onPressed: onPressed ??
          () async {
            await Future.delayed(const Duration(milliseconds: 100));
            Get.back();
          },
      child: Icon(
        iconData,
        size: _height * 0.03,
      ),
    );
  }
}
