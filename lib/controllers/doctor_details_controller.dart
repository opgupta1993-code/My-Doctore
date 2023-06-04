import 'package:flutter_hello_my_doctor/controllers/select_doctor_controller.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../networking/network_calls.dart';
import '../utils/utils.dart';

class DoctorDetailsController extends GetxController {
  late final RxBool loading;

  DoctorModel? _data;

  late final SelectDoctorController _selectDoctorController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;

    _selectDoctorController = Get.find<SelectDoctorController>();
    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getDoctorDetails({
      "doctor_id": _selectDoctorController.selectedDoctor?.id,
    });

    if (res.containsKey("status") && res["status"] == "200") {
      final Map data = res["data"] ?? {};

      if (data.isNotEmpty) {
        _data = DoctorModel.fromJson(data);
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> onBookNowPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.makeAppointmentScreen();
  }

  void onWriteReviewPressed() {}

  DoctorModel? get data => _data;
}
