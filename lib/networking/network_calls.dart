import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'dio_api.dart';

class NetworkCalls {
  static final List<CancelToken> _cancelTokenList = [];

  static Future<Map> _getRequest(
    String path, {
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
  }) async {
    cancelToken ??= CancelToken();
    _cancelTokenList.add(cancelToken);

    Map res = {
      "success": false,
      "message": "Something went wrong, please try again later"
    };

    try {
      final Dio? dio = DioAPI.getDioInstance();
      final Response response = await dio!.get(
        path,
        queryParameters: data,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (int? status) {
            return true;
          },
        ),
        cancelToken: cancelToken,
      );

      // log("Response :: $path ::${response.data}");

      res = response.data;
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Map> _postRequest(
    String path, {
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? headers,
    dynamic data,
    CancelToken? cancelToken,
    bool jsondecode = false,
  }) async {
    cancelToken ??= CancelToken();
    _cancelTokenList.add(cancelToken);

    Map res = {
      "success": false,
      "message": "Something went wrong, please try again later"
    };

    try {
      final Dio? dio = DioAPI.getDioInstance();
      final Response response = await dio!.post(
        path,
        data: data,
        queryParameters: queryParam,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (int? status) {
            return true;
          },
        ),
        cancelToken: cancelToken,
      );

      if (jsondecode) {
        res = jsonDecode(response.data);
      } else {
        res = response.data;
      }
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Map> _putRequest(
    String path, {
    Map<String, dynamic>? queryParam,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    cancelToken ??= CancelToken();
    _cancelTokenList.add(cancelToken);

    Map res = {
      "success": false,
      "message": "Something went wrong, please try again later"
    };

    try {
      final Dio? dio = DioAPI.getDioInstance();
      final Response response = await dio!.put(
        path,
        data: data,
        queryParameters: queryParam,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (int? status) {
            return true;
          },
        ),
        cancelToken: cancelToken,
      );

      // log("Res :: $path :: ${response.data}");

      res = response.data;
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Object?> _billDeskPostRequest(
    String path, {
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? headers,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    cancelToken ??= CancelToken();
    _cancelTokenList.add(cancelToken);

    Object? res;

    try {
      final Dio? dio = DioAPI.getDioInstance();
      final Response response = await dio!.post(
        path,
        data: data,
        queryParameters: queryParam,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (int? status) {
            return true;
          },
        ),
        cancelToken: cancelToken,
      );

      // log("Res :: $path :: ${response.data}");

      res = response.data;
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Map> login(Map<String, dynamic> data) async {
    const String path = "/wb/login";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> signup(Map<String, dynamic> data) async {
    const String path = "/wb/signup";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> verifyOTP(Map<String, dynamic> data) async {
    const String path = "/wb/signup_otp_verify";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> resendOTP(Map<String, dynamic> data) async {
    const String path = "/wb/signup_resend_otp";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getDoctorCategories() async {
    const String path = "/wb/categories";
    return await _postRequest(path);
  }

  static Future<Map> getCities() async {
    const String path = "/wb/locations";
    return await _postRequest(path);
  }

  static Future<Map> getDoctors(Map<String, dynamic> data) async {
    const String path = "/wb/doctor_search";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getDoctorDetails(Map<String, dynamic> data) async {
    const String path = "/wb/doctor_details";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> initiatePayment(Map<String, dynamic> data) async {
    const String path = "/paytm/initiate_transaction";
    return await _postRequest(
      path,
      data: FormData.fromMap(data),
      jsondecode: true,
    );
  }

  static Future<Map> bookAppointment(Map<String, dynamic> data) async {
    const String path = "/wb/appointment_booking";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getHome(Map<String, dynamic> data) async {
    const String path = "/wb/home";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> submitReviewRating(Map<String, dynamic> data) async {
    const String path = "/wb/doctor_rating";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> sendForgotPasswordOTP(Map<String, dynamic> data) async {
    const String path = "/wb/forgot_password";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> verifyForgotPasswordOTP(Map<String, dynamic> data) async {
    const String path = "/wb/otp_verification";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> resetPassword(Map<String, dynamic> data) async {
    const String path = "/wb/reset_password";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> updateProfile(Map<String, dynamic> data) async {
    const String path = "/wb/update_profile";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getNotifications(Map<String, dynamic> data) async {
    const String path = "/wb/get_notification";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getAppointments(Map<String, dynamic> data) async {
    const String path = "/wb/get_appointments";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getLocationWiseFees(Map<String, dynamic> data) async {
    const String path = "/wb/location_fee";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> checkDoctorAvailability(Map<String, dynamic> data) async {
    const String path = "/wb/check_availability";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> createBillDeskOrder(Map<String, dynamic> data) async {
    const String path = "/dev/wb/create_order";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  // BillDesk
  static Future<Object?> createOrder(
    String jsonEncodedData,
    Map<String, dynamic> headers,
  ) async {
    return await _billDeskPostRequest(
      Constants.createOrderProductionAPI,
      data: jsonEncodedData,
      headers: headers,
    );
  }
}
