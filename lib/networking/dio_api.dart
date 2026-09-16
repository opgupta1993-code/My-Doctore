import 'package:dio/dio.dart';

class DioAPI {
  static Dio? _dio;

  static String baseURL = "https://hellomydoctor.in";

  static Dio? getDioInstance() {
    try {
      if (_dio == null) {
        _dio = Dio(
          BaseOptions(
            baseUrl: baseURL,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
          ),
        );
      }
    } catch (err) {
      // debugPrint("Error - DioAPI :- ${err.toString()}");
    }

    return _dio;
  }
}
