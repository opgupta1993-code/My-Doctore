import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/select_doctor_category_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../models/doctor_model.dart';
import '../networking/network_calls.dart';
import '../utils/utils.dart';

class SelectDoctorController extends GetxController {
  late final RxBool loading;

  DoctorDetailsModel? selectedDoctor;

  late final List<DoctorDetailsModel> _dataList;

  late String _searchedText;

  Timer? _timer;

  late final TextEditingController searchController;

  SelectDoctorCategoryController? _selectDoctorCategoryController;
  late final SelectCityController _selectCityController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    _dataList = <DoctorDetailsModel>[].obs;
    selectedDoctor = null;

    _searchedText = "";

    searchController = TextEditingController();

    if (Get.isRegistered<SelectDoctorCategoryController>()) {
      _selectDoctorCategoryController =
          Get.find<SelectDoctorCategoryController>();
    }

    _selectCityController = Get.find<SelectCityController>();

    _getData();
  }

  Future<void> _getData() async {
    if (_dataList.isNotEmpty) {
      _dataList.clear();
    }

    final Map res = await NetworkCalls.getDoctors({
      "category_id":
          _selectDoctorCategoryController?.selectedDoctorCategory?.id,
      "location_id": _selectCityController.selectedCity?.id,
      "search_key": searchController.text,
    });

    if (res.containsKey("status") && res["status"] == "200") {
      final List dataList = res["data"] ?? [];

      if (dataList.isNotEmpty) {
        for (Map d in dataList) {
          _dataList.add(DoctorDetailsModel.fromJson(d));
        }
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  void onCanclePressed() {
    searchController.clear();
  }

  Future<void> onBookNowPressed(DoctorDetailsModel data) async {
    selectedDoctor = data;

    await Future.delayed(const Duration(milliseconds: 100));
    Routes.makeAppointmentScreen(data);
  }

  Future<void> onDoctorPressed(DoctorDetailsModel data) async {
    selectedDoctor = data;
    Routes.doctorDetailsScreen(data);
  }

  void onClearPressed() {
    searchController.clear();
    _cancelTimer();
  }

  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  Future<void> onSearch(String value) async {
    if (value != _searchedText) {
      _searchedText = value;
      _cancelTimer();

      if (value.isNotEmpty) {
        loading.value = true;
        _timer = Timer(const Duration(milliseconds: 500), _getData);
      } else {
        _dataList.clear();
        _getData();
      }
    }
  }

  List<DoctorDetailsModel> get dataList => _dataList;

  @override
  void onClose() {
    searchController.dispose();
    _cancelTimer();

    super.onClose();
  }
}
