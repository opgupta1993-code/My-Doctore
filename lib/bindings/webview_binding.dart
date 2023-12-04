import 'package:get/get.dart';

import '../controllers/webview_controller.dart';

class WebviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebviewController());
  }
}
