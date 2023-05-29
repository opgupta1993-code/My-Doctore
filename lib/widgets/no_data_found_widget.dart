import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String _data;
  final bool isCenter;
  NoDataFoundWidget(this._data, {this.isCenter = true, Key? key})
      : super(key: key);

  final double _height = Get.height;

  @override
  Widget build(BuildContext context) {
    return isCenter
        ? Center(
            child: Text(
              _data,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: _height * 0.02,
              ),
            ),
          )
        : Text(
            _data,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: _height * 0.02,
            ),
          );
  }
}
