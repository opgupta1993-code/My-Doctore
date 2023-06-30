import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/models/city_model.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';

class SelectCityController extends GetxController {
  late final RxBool loading;
  late final RxList dataList;
  late final List<CityModel> _allDataList;

  late final TextEditingController searchController;

  CityModel? _selectedCity;

  bool? afterLogin;

  late final SharedPreferences _sharedPreferences;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    dataList = <CityModel>[].obs;
    _allDataList = <CityModel>[];

    _sharedPreferences = Get.find<SharedPreferences>();

    searchController = TextEditingController();

    afterLogin = Get.arguments == null ? false : Get.arguments["data"] ?? false;

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getCities();

    if (res.containsKey("status") && res["status"] == "200") {
      final List dataList = res["data"] ?? [];

      if (dataList.isNotEmpty) {
        for (Map d in dataList) {
          _allDataList.add(CityModel.fromJson(d));
        }
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    dataList.assignAll(_allDataList);

    loading.value = false;
  }

  Future<void> onCitySelected(
    CityModel data, {
    bool navigateFurther = true,
  }) async {
    _selectedCity = data;

    final Map? jsonData = _selectedCity?.toJson();

    if (jsonData != null) {
      await _sharedPreferences.setString("selectedCity", jsonEncode(jsonData));
      await _sharedPreferences.setBool("isCitySelected", true);
    }

    if (navigateFurther) {
      await Future.delayed(const Duration(milliseconds: 50));
      Routes.drawerScreen();
    }
  }

  void onCanclePressed() {
    searchController.clear();

    dataList.clear();
    dataList.assignAll(_allDataList);
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      dataList.clear();
      dataList.assignAll(_allDataList);
    } else {
      final List<CityModel> searchedData = _allDataList
          .where(
            (element) =>
                element.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();

      dataList.clear();
      dataList.assignAll(searchedData);
    }
  }

  CityModel? get selectedCity => _selectedCity;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
