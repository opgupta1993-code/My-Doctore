import 'package:flutter_hello_my_doctor/models/doctor_category_model.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';

class SelectDoctorCategoryController extends GetxController {
  late final RxBool loading;
  late final List<DoctorCategoryModel> _dataList;

  DoctorCategoryModel? _selectedDoctorCategory;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;
    _dataList = <DoctorCategoryModel>[];

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getDoctorCategories();

    if (res.containsKey("status") && res["status"] == "200") {
      final List dataList = res["data"] ?? [];

      if (dataList.isNotEmpty) {
        for (Map d in dataList) {
          _dataList.add(DoctorCategoryModel.fromJson(d));
        }
      }
    } else {
      Utils.showToast("${res["msg"]}");
    }

    loading.value = false;
  }

  Future<void> onCategorySelected(DoctorCategoryModel data) async {
    _selectedDoctorCategory = data;

    await Future.delayed(const Duration(milliseconds: 100));
    Routes.selectCityScreen();
  }

  List<DoctorCategoryModel> get dataList => _dataList;
  DoctorCategoryModel? get selectedDoctorCategory => _selectedDoctorCategory;
}
