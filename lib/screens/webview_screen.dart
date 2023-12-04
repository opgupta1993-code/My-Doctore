import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/webview_controller.dart';
import '../utils/theme_utils.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/circular_loading_widget.dart';

// ignore: must_be_immutable
class WebviewScreen extends StatelessWidget {
  WebviewScreen({Key? key}) : super(key: key);

  final double _height = Get.height, _width = Get.width;
  WebviewController? _controller;

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
          child: BackButtonWidget(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _controller ??= Get.find<WebviewController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        appBar: _buildAppbarWidget,
        body: Padding(
          padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
          child: Stack(
            alignment: Alignment.center,
            children: [
              WebViewWidget(
                controller: _controller!.webViewController,
                // initialUrl: _controller.url,
                // javascriptMode: JavascriptMode.unrestricted,
                // allowsInlineMediaPlayback: true,
                // onPageFinished: _controller.onPageFinished,
              ),
              Obx(
                () => _controller!.loading.value
                    ? CircularLoadingWidget(_width, center: true)
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
