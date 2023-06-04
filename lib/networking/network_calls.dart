import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

      log("Response :: $path ::${response.data}");

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
      final Response response = await dio!.post(
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

      log("Res :: $path :: ${response.data}");

      res = response.data;
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

      log("Res :: $path :: ${response.data}");

      res = response.data;
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Map> login(Map<String, dynamic> data) async {
    const String path = "/login";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> signup(Map<String, dynamic> data) async {
    const String path = "/signup";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getDoctorCategories() async {
    const String path = "/categories";
    return await _postRequest(path);
  }

  static Future<Map> getCities() async {
    const String path = "/locations";
    return await _postRequest(path);
  }

  static Future<Map> getDoctors(Map<String, dynamic> data) async {
    const String path = "/doctors";
    return await _postRequest(path, data: FormData.fromMap(data));
  }

  static Future<Map> getDoctorDetails(Map<String, dynamic> data) async {
    const String path = "/doctor_details";
    return await _postRequest(path, data: FormData.fromMap(data));
  }
}
