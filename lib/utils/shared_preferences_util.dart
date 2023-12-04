import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences> getSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }
}
