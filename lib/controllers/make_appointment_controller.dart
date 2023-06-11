import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/select_doctor_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:flutter_hello_my_doctor/utils/payment_gateway.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MakeAppointmentController extends GetxController {
  late final RxBool loading;

  late final GlobalKey<FormState> _formKey;

  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final TextEditingController fhNameController;
  late final TextEditingController mobileController;
  late final TextEditingController addressController;
  late final TextEditingController dateController;

  late final SelectCityController _selectCityController;
  late final SelectDoctorController _selectDoctorController;
  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    loading = false.obs;

    _selectCityController = Get.find<SelectCityController>();
    _selectDoctorController = Get.find<SelectDoctorController>();
    _userController = Get.find<UserController>();

    _formKey = GlobalKey<FormState>(debugLabel: "Make Appointment Form Key");

    nameController = TextEditingController();
    ageController = TextEditingController();
    fhNameController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    dateController = TextEditingController();
  }

  Future<Map?> _initiatePayment() async {
    final Map res = await NetworkCalls.initiatePayment({
      "user_id": _userController.user.value.userId,
      "amount": _selectDoctorController.selectedDoctor?.fees,
    });

    if (res.containsKey("body")) {
      final Map body = res["body"];

      final Map resultInfo = body["resultInfo"];

      if (resultInfo.containsKey("resultStatus") &&
          resultInfo["resultStatus"] == "S") {
        return {"txnToken": body["txnToken"], "orderId": res["orderId"]};
      }

      Utils.showToast("Payment failed, please try agian");
      return null;
    } else {
      Utils.showToast("Payment failed, please try agian");
      return null;
    }
  }

  Future<void> _bookAppointment(Map<String, dynamic> data) async {
    final Map res = await NetworkCalls.bookAppointment(data);

    if (res["status"] == "200") {
      Utils.showToast("Appointment booked successfully", color: Colors.green);
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
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

  Future<void> onContinuePressed() async {
    Utils.removeFocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_userController.isLogin.value) {
      Routes.loginScreen();
      return;
    }

    await Future.delayed(const Duration(milliseconds: 100));
    loading.value = true;

    final Map? data = await _initiatePayment();

    if (data != null) {
      final Map? res = await PaymentGateway.pay(
        trnxToken: data["txnToken"],
        amount: _selectDoctorController.selectedDoctor?.fees ?? "0",
        orderId: "${data["orderId"]}",
      );

      if (res == null) {
        if (loading.value) {
          loading.value = false;
        }
      } else {
        late final Map gatewayResponse;

        if (Platform.isAndroid) {
          gatewayResponse = res;
        } else if (Platform.isIOS) {
          gatewayResponse = res["response"];
        }

        final Map<String, dynamic> data = {
          "user_id": _userController.user.value.userId,
          "location_id": _selectCityController.selectedCity?.id,
          "category_id": _selectDoctorController.selectedDoctor?.categoryId,
          "doctor_id": _selectDoctorController.selectedDoctor?.id,
          "patient_name": nameController.text,
          "age": ageController.text,
          "father_name": fhNameController.text,
          "husband_name": fhNameController.text,
          "mobile_number": mobileController.text,
          "address": addressController.text,
          "date": dateController.text,
          "fees": _selectDoctorController.selectedDoctor?.fees,
          "TXNAMOUNT": gatewayResponse["TXNAMOUNT"],
          "TXNDATE": gatewayResponse["TXNDATE"],
          "BANKTXNID": gatewayResponse["BANKTXNID"],
          "GATEWAYNAME": gatewayResponse["GATEWAYNAME"],
          "CHECKSUMHASH": gatewayResponse["CHECKSUMHASH"],
          "STATUS": gatewayResponse["STATUS"],
          "ORDERID": gatewayResponse["ORDERID"],
          "MID": gatewayResponse["MID"],
          "PAYMENTMODE": gatewayResponse["PAYMENTMODE"],
          "RESPCODE": gatewayResponse["RESPCODE"],
          "CURRENCY": gatewayResponse["CURRENCY"],
          "RESPMSG": gatewayResponse["RESPMSG"],
        };

        await _bookAppointment(data);
      }
    } else {
      loading.value = false;
    }
  }

  GlobalKey<FormState> get formKey => _formKey;

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
}
