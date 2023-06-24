import 'package:flutter_hello_my_doctor/models/appointment_model.dart';
import 'package:get/get.dart';

class AppointmentsController extends GetxController {
  late final RxBool loading;

  late final List<AppointmentModel> _dataList;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;

    _dataList = <AppointmentModel>[];
  }

  List<AppointmentModel> get dataList => _dataList;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
