import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/intro_page_view_controller.dart';
import '../../utils/theme_utils.dart';

// ignore: must_be_immutable
class IntroPageViewScreen extends StatelessWidget {
  IntroPageViewScreen({Key? key}) : super(key: key);

  IntroPageViewController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<IntroPageViewController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        body: PageView.builder(
          itemCount: _controller!.screenList.length,
          controller: _controller!.pageController,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          onPageChanged: _controller!.onPageChange,
          itemBuilder: (BuildContext context, int index) =>
              _controller!.screenList[index],
        ),
      ),
    );
  }
}
