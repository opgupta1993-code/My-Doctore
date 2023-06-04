import 'package:flutter_hello_my_doctor/models/city_model.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class SelectCityController extends GetxController {
  late final RxBool loading;
  late final List<CityModel> _dataList;
  CityModel? _selectedCity;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    _dataList = <CityModel>[];

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getCities();

    if (res.containsKey("status") && res["status"] == "200") {
      final List dataList = res["data"] ?? [];

      if (dataList.isNotEmpty) {
        for (Map d in dataList) {
          _dataList.add(CityModel.fromJson(d));
        }
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> onCitySelected(CityModel data) async {
    _selectedCity = data;

    await Future.delayed(const Duration(milliseconds: 100));
    // Routes.selectDoctorScreen();
    Routes.drawerScreen();
  }

  List<CityModel> get dataList => _dataList;
  CityModel? get selectedCity => _selectedCity;
}
