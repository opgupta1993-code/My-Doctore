import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/utils.dart';
import 'dio_api.dart';

class NetworkCalls {
  static final List<CancelToken> _cancelTokenList = [];

  static Future<bool> _isSesssionExpired(Map res) async {
    if (!(res.containsKey("success") &&
            res["success"] != null &&
            res["success"]) &&
        "${res["msg"]}".trim().toUpperCase() == "TOKEN EXPIRED") {
      Utils.showToast("Session Expired");

      // Cancel all pending network requests
      for (CancelToken cancelToken in _cancelTokenList) {
        cancelToken.cancel("Session Expired");
      }

      await Utils.logout();
      return true;
    }

    return false;
  }

  static Future<Map> _getRequest(
    String path, {
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
  }) async {
    cancelToken ??= CancelToken();
    _cancelTokenList.add(cancelToken);

    Map res = {
      "success": false,
      "msg": "Something went wrong, please try again later"
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
      final bool isSessionExpired = await _isSesssionExpired(response.data);

      if (isSessionExpired) {
        return {"success": false, "msg": "Session Expired"};
      }

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
      "msg": "Something went wrong, please try again later"
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
      final bool isSessionExpired = await _isSesssionExpired(response.data);

      if (isSessionExpired) {
        return {"success": false, "msg": "Session Expired"};
      }

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
      "msg": "Something went wrong, please try again later"
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
      final bool isSessionExpired = await _isSesssionExpired(response.data);

      if (isSessionExpired) {
        return {"success": false, "msg": "Session Expired"};
      }

      res = response.data;
    } catch (err) {
      debugPrint("Error - NetworkCalls - $path :- ${err.toString()}");
      return res;
    }

    _cancelTokenList.remove(cancelToken);

    return res;
  }

  static Future<Map> login(Map<String, dynamic> data) async {
    const String path = "/auth/login";
    return await _postRequest(path, data: jsonEncode(data));
  }

  static Future<Map> signup(Map<String, dynamic> data) async {
    const String path = "/auth/signup";
    return await _postRequest(path, data: jsonEncode(data));
  }

  static Future<Map> getDoctorCategories() async {
    const String path = "/categories";
    return await _postRequest(path);
  }

  static Future<Map> getCities() async {
    const String path = "/locations";
    return await _postRequest(path);
  }
}
