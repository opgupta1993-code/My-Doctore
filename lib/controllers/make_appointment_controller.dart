import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:billDeskSDK/sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'package:flutter_hello_my_doctor/constants/patient_type_enum.dart';
import 'package:flutter_hello_my_doctor/controllers/select_city_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:flutter_hello_my_doctor/utils/payment_gateway.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MakeAppointmentController extends GetxController {
  late final RxBool loading;
  late final RxBool enableContinue;
  late final RxString ageType;
  late final RxString nameType;
  late final RxBool _togglePaymentSuccessDialog;
  late final Rx<PatientType> selectedPatientType;

  late final List<DropdownMenuItem<String>> _ageTypeList;
  late final List<DropdownMenuItem<String>> _nameTypeList;

  StreamSubscription? _paymentSuccessDialogStateSubscription;

  late final GlobalKey<FormState> _formKey;

  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final TextEditingController fhNameController;
  late final TextEditingController mobileController;
  late final TextEditingController addressController;
  late final TextEditingController dateController;

  late double _locationWiseFee;
  late String _husbandFatherText;

  late final SelectCityController _selectCityController;
  DoctorDetailsModel? _selectedDoctor;
  // late final SelectDoctorController _selectDoctorController;
  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    loading = false.obs;
    enableContinue = false.obs;
    _togglePaymentSuccessDialog = false.obs;
    selectedPatientType = PatientType.newPatient.obs;

    _selectCityController = Get.find<SelectCityController>();
    // _selectDoctorController = Get.find<SelectDoctorController>();
    _userController = Get.find<UserController>();

    _selectedDoctor = Get.arguments["data"];
    _husbandFatherText = "Father/Husband's name";

    if (_selectedDoctor!.categoryId == "19") {
      _husbandFatherText = "Name";

      _nameTypeList = <DropdownMenuItem<String>>[
        const DropdownMenuItem(
          value: "husband",
          child: Text("Husband"),
        ),
        const DropdownMenuItem(
          value: "father",
          child: Text("Father"),
        ),
      ];

      nameType = "husband".obs;
    } else if (_selectedDoctor!.categoryId == "20") {
      _husbandFatherText = "Father's name";
    }

    ageType = "years".obs;

    _ageTypeList = <DropdownMenuItem<String>>[
      const DropdownMenuItem(
        value: "years",
        child: Text("Years"),
      ),
      const DropdownMenuItem(
        value: "months",
        child: Text("Months"),
      ),
      const DropdownMenuItem(
        value: "days",
        child: Text("Days"),
      ),
    ];

    _formKey = GlobalKey<FormState>(debugLabel: "Make Appointment Form Key");

    nameController = TextEditingController();
    ageController = TextEditingController();
    fhNameController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    dateController = TextEditingController();

    _locationWiseFee = 0.0;

    _getLocationWiseFees();
  }

  Future<void> _checkDoctorAvailability(String bookingDate) async {
    final Map res = await NetworkCalls.checkDoctorAvailability({
      "booking_date": bookingDate,
      "doctor_id": _selectedDoctor?.id,
    });

    enableContinue.value = res["status"] == "200";

    if (res["status"] != "200") {
      Utils.showToast("${res["message"]}");
    }
  }

  Future<Map?> _initiatePayment(double amount) async {
    final Map res = await NetworkCalls.initiatePayment({
      "user_id": _userController.user.value.userId,
      "amount": amount,
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
      _togglePaymentSuccessDialog.value = !_togglePaymentSuccessDialog.value;
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> _getLocationWiseFees() async {
    final Map res = await NetworkCalls.getLocationWiseFees(
      {"location_id": _selectCityController.selectedCity?.id},
    );

    if (res["status"] == "200") {
      final Map data = res["data"] ?? {};

      if (data.containsKey("fee")) {
        _locationWiseFee = Utils.getDoubleFromString("${data["fee"]}");
      }
    }
  }

  Future<void> openDatePicker() async {
    DateTime current = DateTime.now();

    final TimeOfDay currentTime = TimeOfDay.now();

    if (currentTime.hour > 9) {
      current = current.add(const Duration(days: 1));
    }

    final DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      currentDate: DateTime.now(),
      initialDate: current,
      firstDate: current,
      lastDate: DateTime(current.year + 5),
    );

    if (dateTime != null) {
      enableContinue.value = false;
      dateController.text = DateFormat("yyyy-MM-dd").format(dateTime);

      _checkDoctorAvailability(dateController.text);
    }
  }

  Future<void> listenPaymentSuccessDialogState(Function showDialog) async {
    _paymentSuccessDialogStateSubscription =
        _togglePaymentSuccessDialog.listen((data) async {
      showDialog();
    });
  }

  Future<void> onContinuePressed() async {
    Utils.removeFocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_userController.isLogin.value) {
      Routes.loginScreen(
        isDirectLogin: false,
        previousRoute: "/makeAppointmentScreen",
      );
      return;
    }

    if (!enableContinue.value) return;

    await Future.delayed(const Duration(milliseconds: 100));
    loading.value = true;

    double amount = 0.0;

    if (selectedPatientType.value == PatientType.existingPatient) {
      // existing patient
      amount = _locationWiseFee;
    } else {
      // new patient
      if (_selectedDoctor?.isBookingChargesApplied ?? false) {
        amount = _locationWiseFee +
            Utils.getDoubleFromString("${_selectedDoctor?.fees}");
      } else {
        amount = _locationWiseFee;
      }
    }

    // create order
    final Map res = await NetworkCalls.createBillDeskOrder({
      "user_id": _userController.user.value.userId,
      "amount": amount,
      // "amount": 1
    });

    if (res["status"] == "200") {
      final Map data = res["data"] ?? {};

      final Map<String, dynamic> sdkConfigJson = {
        "flowConfig": {
          "merchantId": data["mercid"],
          "bdOrderId": data["bdorderid"],
          "authToken": data["links"][1]["headers"]["authorization"],
          "childWindow": false,
          "retryCount": 0
        },
        "flowType": "payments",
        "merchantLogo": "",
      };

      final ResponseHandler responseHandler = SdkResponseHandler(
        onResponse: (TxnInfo txnInfo) {
          // log("onResponse --> ${txnInfo.txnInfoMap}");

          // {isCancelledByUser: false, orderId: 20240111166, customerRefId: , merchantId: HMYDOC2}

          if (txnInfo.txnInfoMap.containsKey("isCancelledByUser") &&
              txnInfo.txnInfoMap["isCancelledByUser"]) {
            // cancelled by user
            Utils.showToast("Payment cancelled");

            loading.value = false;
          } else {
            // payment might have been done
            // verify from backend
            final Map<String, dynamic> data = {
              "user_id": _userController.user.value.userId,
              "location_id": _selectCityController.selectedCity?.id,
              "category_id": _selectedDoctor?.categoryId,
              "doctor_id": _selectedDoctor?.id,
              "patient_name": nameController.text,
              "age": ageController.text,
              "age_type": ageType.value.toLowerCase(),
              "father_name": fhNameController.text,
              "husband_name": fhNameController.text,
              "mobile_number": mobileController.text,
              "address": addressController.text,
              "date": dateController.text,
              "fees": amount,
              "orderid": txnInfo.txnInfoMap["orderId"],
            };

            if (_selectedDoctor?.categoryId == "19") {
              data["hf_type"] = nameType.value;
            }

            _bookAppointment(data);
          }
        },
        onErrorResponse: (SdkError sdkError) {
          // log("onErrorResponse --> $sdkError");
          loading.value = false;
        },
      );

      final SdkConfig sdkConfig = SdkConfig(
        responseHandler: responseHandler,
        isUATEnv: false,
        isDevModeAllowed: true,
        isJailBreakAllowed: false,
        sdkConfigJson: SdkConfiguration.fromJson(sdkConfigJson),
      );

      Get.to(() => const SDKWebView(), arguments: sdkConfig);
    } else {
      loading.value = false;
    }
  }

  Future<void> onDonePressed() async {
    Get.until((route) => route.settings.name == "/drawerScreen");
    Routes.appointmentsScreen();
  }

  void onPatientTypeChanged(PatientType? value) {
    if (value == null) return;

    selectedPatientType.value = value;
  }

  void onAgeTypeChanged(String? value) {
    if (value == null) return;

    ageType.value = value;
  }

  void onNameTypeChanged(String? value) {
    if (value == null) return;

    nameType.value = value;
  }

  GlobalKey<FormState> get formKey => _formKey;
  DoctorDetailsModel? get selectedDoctor => _selectedDoctor;
  List<DropdownMenuItem<String>> get ageTypeList => _ageTypeList;
  List<DropdownMenuItem<String>> get nameTypeList => _nameTypeList;
  String get husbandFatherText => _husbandFatherText;

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    fhNameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    dateController.dispose();

    _paymentSuccessDialogStateSubscription?.cancel();
    super.onClose();
  }
}
