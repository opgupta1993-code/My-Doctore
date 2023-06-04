import 'package:get/get.dart';

import '../controllers/select_city_controller.dart';

class SelectCityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SelectCityController(), permanent: true);
  }
}
