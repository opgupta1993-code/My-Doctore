import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/models/appointment_model.dart';
import 'package:get/get.dart';

import '../networking/network_calls.dart';
import '../utils/utils.dart';

class AppointmentsController extends GetxController {
  late final RxBool loading;

  late final List<AppointmentModel> _dataList;

  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;

    _userController = Get.find<UserController>();

    _dataList = <AppointmentModel>[];

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getAppointments({
      "user_id": _userController.user.value.userId,
      // "user_id": "2",
    });

    if (res.containsKey("status") && res["status"] == "200") {
      if (res.containsKey("data") && res["data"] is Map) {
        final Map data = res["data"] ?? {};

        if (data.containsKey("appointment_data") &&
            data["appointment_data"] is List) {
          final List dataList = data["appointment_data"];

          if (dataList.isNotEmpty) {
            for (Map d in dataList) {
              _dataList.add(AppointmentModel.fromJson(d));
            }
          }
        }
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    print(_dataList.length);

    loading.value = false;
  }

  List<AppointmentModel> get dataList => _dataList;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
