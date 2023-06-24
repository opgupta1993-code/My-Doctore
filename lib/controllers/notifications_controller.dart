import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../models/notification_model.dart';
import '../networking/network_calls.dart';
import '../utils/utils.dart';

class NotificationsController extends GetxController {
  late final RxBool loading;

  late final List<NotificationModel> _dataList;

  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;

    _userController = Get.find<UserController>();
    _dataList = <NotificationModel>[];

    _getData();
  }

  Future<void> _getData() async {
    final Map res = await NetworkCalls.getNotifications({
      "user_id": _userController.user.value.userId,
    });

    if (res.containsKey("status") && res["status"] == "200") {
      final List dataList = res["data"] ?? [];

      if (dataList.isNotEmpty) {
        for (Map d in dataList) {
          _dataList.add(NotificationModel.fromJson(d));
        }
      }
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> onNotificationPressed(NotificationModel data) async {
    await Future.delayed(const Duration(milliseconds: 100));

    switch (data.type.toUpperCase()) {
      case "DOCTOR":
        Routes.doctorDetailsScreen(data.doctorId);
        break;

      case "LOCATION":
        Routes.selectCityScreen();
        break;
    }
  }

  List<NotificationModel> get dataList => _dataList;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
