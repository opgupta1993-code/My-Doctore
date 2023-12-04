import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/custom_colors.dart';

class CircularLoadingWidget extends StatelessWidget {
  final double _width;
  final Color? color;
  final bool center;

  const CircularLoadingWidget(this._width,
      {Key? key, this.color, this.center = false})
      : super(key: key);

  Widget get _buildCircularProgressWidget => CircularProgressIndicator(
        strokeWidth: _width * 0.008,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? HexColor(CustomColors.blue1),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return center
        ? Center(child: _buildCircularProgressWidget)
        : _buildCircularProgressWidget;
  }
}
