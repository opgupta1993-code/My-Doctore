import 'package:get/get.dart';

import '../controllers/intro_page_view_controller.dart';

class IntroPageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroPageViewController());
  }
}
