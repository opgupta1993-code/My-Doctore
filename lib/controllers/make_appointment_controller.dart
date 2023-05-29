import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MakeAppointmentController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final TextEditingController fhNameController;
  late final TextEditingController mobileController;
  late final TextEditingController addressController;
  late final TextEditingController dateController;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    ageController = TextEditingController();
    fhNameController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    dateController = TextEditingController();
  }

  Future<void> openDatePicker() async {
    final DateTime current = DateTime.now();

    final DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      initialDate: current,
      firstDate: current,
      lastDate: DateTime(current.year + 50),
    );

    if (dateTime != null) {
      dateController.text = DateFormat("dd-MM-yyyy").format(dateTime);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    fhNameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    dateController.dispose();

    super.onClose();
  }

  void onContinuePressed() {}
}
