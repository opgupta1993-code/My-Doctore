import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/drawer_controller.dart'
    as dc;
import 'package:get/get.dart';

class DrawerMenuButtonWidget extends StatelessWidget {
  final BoxConstraints _cons;
  DrawerMenuButtonWidget(this._cons, {Key? key}) : super(key: key);

  final dc.DrawerController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_cons.maxWidth),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(_cons.maxHeight * 0.15),
        ),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(
          Colors.white.withOpacity(0.3),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
      ),
      onPressed: _controller.onDrawerMenuPressed,
      child: Icon(
        Icons.menu,
        size: _cons.maxHeight * 0.5,
      ),
    );
  }
}
