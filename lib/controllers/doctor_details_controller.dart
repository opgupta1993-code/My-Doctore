import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/select_doctor_controller.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:flutter_hello_my_doctor/routes/routes.dart';
import 'package:get/get.dart';

import '../networking/network_calls.dart';
import '../utils/utils.dart';

class DoctorDetailsController extends GetxController {
  late final RxBool loading, reviewRatingLoading;
  late final RxBool _reviewRatingSheet;

  late double _rating;

  StreamSubscription? _reviewRatingBottomSheetStateSubscription;

  bool? _isReviewRatingSheetOpen;

  DoctorModel? _data;

  late final TextEditingController descController;

  late final SelectDoctorController _selectDoctorController;
  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();

    loading = true.obs;

    reviewRatingLoading = false.obs;
    _reviewRatingSheet = false.obs;

    _rating = 0.0;

    descController = TextEditingController();

    _selectDoctorController = Get.find<SelectDoctorController>();
    _userController = Get.find<UserController>();
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

  Future<void> _submitReviewRating() async {
    final Map res = await NetworkCalls.submitReviewRating({
      "user_id": _userController.user.value.userId,
      "doctor_id": _selectDoctorController.selectedDoctor?.id,
      "rating": _rating,
      "description": descController.text,
    });

    if (res.containsKey("status") && res["status"] == "200") {
      Utils.showToast("Rated successfully", color: Colors.green);
    } else {
      Utils.showToast("${res["message"]}");
    }

    if (_isReviewRatingSheetOpen != null && _isReviewRatingSheetOpen!) {
      _reviewRatingSheet.value = !_reviewRatingSheet.value;
      await Future.delayed(const Duration(milliseconds: 150));
    }

    if (reviewRatingLoading.value) {
      reviewRatingLoading.value = false;
    }
  }

  Future<void> onBookNowPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Routes.makeAppointmentScreen();
  }

  void onWriteReviewPressed() {
    _reviewRatingSheet.value = !_reviewRatingSheet.value;
  }

  void onRate(double value) {
    _rating = value;
  }

  Future<void> onSubmitReviewPressed() async {
    Utils.removeFocus();
    
    if (_rating == 0.0) {
      Utils.showToast("Please rate");
      return;
    }

    await Future.delayed(const Duration(milliseconds: 100));
    reviewRatingLoading.value = true;

    await _submitReviewRating();
  }

  Future<void> listenReviewRatingBottomSheetState(
    Function showBottomSheet,
  ) async {
    _reviewRatingBottomSheetStateSubscription =
        _reviewRatingSheet.listen((data) async {
      if (_isReviewRatingSheetOpen == null || !_isReviewRatingSheetOpen!) {
        // sheet is open
        _isReviewRatingSheetOpen = true;

        await showBottomSheet();

        // sheet is closed
        _isReviewRatingSheetOpen = false;

        await Future.delayed(const Duration(milliseconds: 150));
        descController.clear();
        _rating = 0.0;

        if (reviewRatingLoading.value) {
          reviewRatingLoading.value = false;
        }
      } else {
        _isReviewRatingSheetOpen = false;
        Get.back(closeOverlays: true);

        await Future.delayed(const Duration(milliseconds: 150));
        descController.clear();
        _rating = 0.0;

        if (reviewRatingLoading.value) {
          reviewRatingLoading.value = false;
        }
      }
    });
  }

  DoctorModel? get data => _data;

  @override
  void onClose() {
    descController.dispose();
    _reviewRatingBottomSheetStateSubscription?.cancel();

    super.onClose();
  }
}
