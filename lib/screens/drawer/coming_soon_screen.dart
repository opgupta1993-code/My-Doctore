import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';

class ComingSoonScreen extends StatelessWidget {
  ComingSoonScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  PreferredSizeWidget get _buildAppbarWidget => PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Container(
          color: Colors.transparent,
          height: AppBar().preferredSize.height + Get.mediaQuery.padding.top,
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top,
            left: _width * 0.03,
            right: _width * 0.03,
          ),
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(builder: (context, cons) {
            return Row(
              children: [
                BackButtonWidget(),
              ],
            );
          }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
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
              Column(
                children: [
                  _buildAppbarWidget,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _height * 0.18,
                          width: _height * 0.18,
                          child: Image.asset("assets/images/logo.webp"),
                        ),
                        SizedBox(height: _height * 0.05),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: _width * 0.06),
                          child: Text(
                            Get.arguments["data"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: _height * 0.02,
                            ),
                          ),
                        ),
                        SizedBox(height: _height * 0.03),
                        Text(
                          "Coming Soon",
                          style: GoogleFonts.poppins(
                            fontSize: _height * 0.028,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
