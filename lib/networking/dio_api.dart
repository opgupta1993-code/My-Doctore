import 'package:dio/dio.dart';

class DioAPI {
  static Dio? _dio;

  static String baseURL = "https://hellomydoctor.in/dev/wb";

  static Dio? getDioInstance() {
    try {
      if (_dio == null) {
        _dio = Dio();
        _dio!.options.baseUrl = baseURL;
      }
    } catch (err) {
      // debugPrint("Error - DioAPI :- ${err.toString()}");
    }

    return _dio;
  }
}
