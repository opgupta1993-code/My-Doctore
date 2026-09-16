import 'package:get/get.dart';

import '../controllers/select_doctor_category_controller.dart';

class SelectDoctorCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectDoctorCategoryController());
  }
}
