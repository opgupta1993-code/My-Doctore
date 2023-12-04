import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  late final RxBool loading;
  late final String _url;

  late final WebViewController _webViewController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    _url = Get.arguments["url"] ?? "";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            loading.value = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_url));
  }

  Future<void> onPageFinished(String data) async {
    loading.value = false;
  }

  WebViewController get webViewController => _webViewController;
}
