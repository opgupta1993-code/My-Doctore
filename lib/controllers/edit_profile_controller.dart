import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../utils/utils.dart';

class EditProfileController extends GetxController {
  late final RxBool loading;
  late final RxString imagePath;
  late final RxBool _showImageSourceSheet;

  late bool _isImageSourceSheetOpen;

  StreamSubscription? _imageBottomSheetStateSubscription;

  late final GlobalKey<FormState> _fKey;

  late final TextEditingController nameController;
  late final TextEditingController mobileController;
  late final TextEditingController dobController;
  late final TextEditingController locationController;

  late final ImagePicker _imagePicker;

  late final UserController _userController;

  @override
  void onInit() {
    super.onInit();
    loading = false.obs;
    imagePath = "".obs;
    _showImageSourceSheet = false.obs;

    _isImageSourceSheetOpen = false;

    _userController = Get.find<UserController>();

    _fKey = GlobalKey<FormState>();

    nameController = TextEditingController(
      text: _userController.user.value.userName,
    );
    mobileController = TextEditingController(
      text: _userController.user.value.mobileNo,
    );
    dobController = TextEditingController(
      text: _userController.user.value.dob,
    );
    locationController = TextEditingController(
      text: _userController.user.value.address,
    );

    _imagePicker = ImagePicker();
  }

  Future<void> _updateProfile(Map<String, dynamic> data) async {
    final Map res = await NetworkCalls.updateProfile(data);

    if (res["status"] == "200") {
      final Map data = res["data"] ?? {};

      final UserModel userModel = UserModel.fromJson(data);

      _userController.setUser = userModel;
      final SharedPreferences preferences = Get.find();

      await preferences.setBool("login", true);
      await preferences.setString("userData", json.encode(data));

      Utils.showToast("Profile updated", color: Colors.green);

      Get.until((route) => route.settings.name == "/profileScreen");
    } else {
      Utils.showToast("${res["message"]}");
    }

    loading.value = false;
  }

  Future<void> _chooseImage(int source) async {
    try {
      ImageSource imageSource;

      switch (source) {
        case 0:
          imageSource = ImageSource.gallery;
          break;
        case 1:
          imageSource = ImageSource.camera;
          break;
        default:
          imageSource = ImageSource.gallery;
      }

      final XFile? pickedFile = await _imagePicker.pickImage(
        source: imageSource,
        imageQuality: 100,
      );

      if (pickedFile == null) return;

      imagePath.value = pickedFile.path;
    } catch (err) {
      //print("Error :: _chooseImage :: $err");
    }
  }

  void selectImage() {
    _showImageSourceSheet.value = !_showImageSourceSheet.value;
  }

  Future<void> listenImageBottomSheetState(
    Function showImageSourceBottomSheet,
  ) async {
    _imageBottomSheetStateSubscription =
        _showImageSourceSheet.listen((data) async {
      if (!_isImageSourceSheetOpen) {
        // sheet is open
        _isImageSourceSheetOpen = true;

        final int? source = await showImageSourceBottomSheet();

        // sheet is closed
        _isImageSourceSheetOpen = false;

        if (source != null) {
          _chooseImage(source);
        }
      }
    });
  }

  Future<void> openDatePicker() async {
    DateTime current = DateTime.now();

    final DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      currentDate: current,
      initialDate: current,
      firstDate: DateTime(current.year - 100),
      lastDate: current,
    );

    if (dateTime != null) {
      dobController.text = DateFormat("dd-MM-yyyy").format(dateTime);
    }
  }

  Future<void> onUpdatePressed() async {
    if (!_fKey.currentState!.validate()) return;

    await Future.delayed(const Duration(milliseconds: 100));

    loading.value = true;

    final Map<String, dynamic> data = {
      "user_id": _userController.user.value.userId,
      "name": nameController.text,
      "contact": mobileController.text,
      "dob": dobController.text,
      "location": locationController.text,
    };

    if (imagePath.isNotEmpty) {
      final dio.MultipartFile multipartFile = await dio.MultipartFile.fromFile(
        imagePath.value,
        filename: basename(imagePath.value),
        contentType: MediaType.parse(
          lookupMimeType(imagePath.value) ?? "",
        ),
      );

      data["user_img"] = multipartFile;
    }

    await _updateProfile(data);
  }

  GlobalKey<FormState> get fKey => _fKey;

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    locationController.dispose();

    _imageBottomSheetStateSubscription?.cancel();
    super.onClose();
  }
}
