import 'package:get/get.dart';

import '../controllers/select_city_controller.dart';

class SelectCityBinding implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SelectCityController>()) {
      Get.put(SelectCityController(), permanent: true);
    }
  }
}
