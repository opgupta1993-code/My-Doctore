import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/theme_utils.dart';
import '../../widgets/back_button_widget.dart';
import '../controllers/video_review_controller.dart';

// ignore: must_be_immutable
class VideoReviewScreen extends StatelessWidget {
  VideoReviewScreen({super.key});

  final double _height = Get.height, _width = Get.width;

  VideoReviewController? _controller;

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
                SizedBox(width: _width * 0.03),
                Expanded(
                  child: Text(
                    "Review",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: cons.maxHeight * 0.32,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<VideoReviewController>();

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
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: BetterPlayer(
                        controller: _controller!.betterPlayerController,
                      ),
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
