import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtil {
  static Future<String> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }
}
