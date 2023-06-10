import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_hello_my_doctor/controllers/drawer_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/models/home_model.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../networking/network_calls.dart';

class HomeController extends GetxController {
  late final RxBool loading;
  late final RxInt currentIndex;

  HomeModel? _data;

  late final CarouselController _carouselController;

  // late final SelectDoctorCategoryController _selectDoctorCategoryController;
  late final SelectCityController _selectCityController;
  late final DrawerController _drawerController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    currentIndex = 0.obs;

    _carouselController = CarouselController();

    // _selectDoctorCategoryController =
    //     Get.find<SelectDoctorCategoryController>();
    _selectCityController = Get.find<SelectCityController>();
    _drawerController = Get.find<DrawerController>();

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getHome({
      // "category_id": _selectDoctorCategoryController.selectedDoctorCategory?.id,
      "location_id": _selectCityController.selectedCity?.id,
    });

    if (res.containsKey("status") && res["status"] == "200") {
      final Map data = res["data"] ?? {};

      if (data.isNotEmpty) {
        _data = HomeModel.fromJson(data);
      }
    }

    loading.value = false;
  }

  void onDrawerMenuPressed() {
    _drawerController.onDrawerMenuPressed();
  }

  void onSeeAllDoctorsPressed() {}

  Future<void> onServiceSelected() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.selectDoctorCategoryScreen();
  }

  void onSliderChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

  HomeModel? get data => _data;
  CarouselController get carouselController => _carouselController;
}
