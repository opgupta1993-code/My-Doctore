import 'package:get/get.dart';

import '../controllers/video_review_controller.dart';

class VideoReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoReviewController());
  }
}
