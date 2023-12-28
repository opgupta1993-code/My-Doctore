import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart' as getIp;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../routes/routes.dart';

class Utils {
  static void removeFocus({BuildContext? context}) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String? notEmptyValidator(val, String message) {
    if (val.toString().trim().isEmpty) {
      return message;
    }

    return null;
  }

  static String? validator2(
    val,
    String message, {
    bool isPwd = false,
    bool isMobile = false,
    bool isPinCode = false,
    bool isOTP = false,
    int otpLength = 4,
    bool isEmail = false,
    bool matchTwoValues = false,
    String val2 = "",
    String? message2,
  }) {
    if (val.toString().trim().isEmpty) {
      return message;
    }

    if (isPwd) {
      return _isPasswordValid(val);
    }

    if (isMobile && val.toString().trim().length != 10) {
      return "Invalid Phone Number!";
    }

    if (isPinCode && val.toString().trim().length != 6) {
      return "Invalid Pin Code!";
    }

    if (isOTP && val.toString().trim().length != otpLength) {
      return "Invalid OTP!";
    }

    if (isEmail && !val.toString().trim().isEmail) {
      return "Invalid Email!";
    }

    if (matchTwoValues && val2.toString().trim().isNotEmpty && val != val2) {
      // matching two values || example : Pwd & Confirm Pwd
      return message2 ?? "Does not match";
    }

    return null;
  }

  static String? _isPasswordValid(String password) {
    if (password.length < 8) {
      return "Should be 8 characters long";
    }
    if (!password.contains(RegExp(r"[a-z]"))) {
      return "At least 1 small alphabet is required";
    }
    if (!password.contains(RegExp(r"[A-Z]"))) {
      return "At least 1 capital alphabet is required";
    }
    if (!password.contains(RegExp(r"[0-9]"))) {
      return "At least 1 numeric character is required";
    }
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "At least 1 special character is required";
    // }
    return null;
  }

  static void showToast(String msg, {Color color = Colors.red}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: Get.height * 0.02,
    );
  }

  static double getDoubleFromString(
    String data, {
    int decimalPlaces = 1,
  }) {
    return double.parse(
      ((double.tryParse(data) ?? int.tryParse(data) ?? 0))
          .toStringAsFixed(decimalPlaces),
    );
  }

  static int getIntFromString(String data) {
    return (double.tryParse(data) ?? int.tryParse(data) ?? 0).toInt();
  }

  static String getTomorrowDayName() {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = now.add(const Duration(days: 1));

    final DateFormat formatter =
        DateFormat.EEEE(); // EEEE gives the full day name
    final String dayName = formatter.format(tomorrow);

    return dayName;
  }

  static String getAmPmOfTime(String time) {
    final DateFormat formatter = DateFormat.jm();
    final DateTime dateTime = DateFormat.Hm().parse(time);
    final String amPm = formatter.format(dateTime);

    return amPm;
  }

  static String convertTo12HourFormat(String time) {
    final DateFormat formatter = DateFormat('h:mm');
    final DateTime dateTime = DateFormat.Hm().parse(time);
    final String formattedTime = formatter.format(dateTime);

    return formattedTime;
  }

  static Future<void> logout() async {
    final SharedPreferences preferences = Get.find();
    final UserController userController = Get.find();

    await preferences.remove("login");
    await preferences.remove("userData");
    await preferences.remove("isCitySelected");
    await preferences.remove("selectedCity");
    Routes.loginWithoutLoginScreen();

    await Future.delayed(const Duration(milliseconds: 300));

    userController.setIsLogin = false;
    userController.setUser = UserModel();
  }

  static Future<void> openUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (err) {
      //print("ERROR :: Utils :: openUrl :: $url");
    }
  }

  static Future<String> getIPAddress() async {
    final getIp.IpAddress ipAddress =
        getIp.IpAddress(type: getIp.RequestType.text);

    return await ipAddress.getIpAddress();
  }

  static Future<(String, Map<String, dynamic>)> generateJws() async {
    // Step 1: Create JWS Header
    final Map<String, dynamic> jwsHeader = {
      'alg': "HS256",
      "clientid": Constants.clientId
    };

    final Map<String, dynamic> payload = {
      "mercid": Constants.merchantId,
      "orderid": "order450608988",
      "amount": "300.00",
      "order_date": DateTime.now().toString(),
      "currency": "356",
      "ru": "https://www.merchant.com/",
      "itemcode": "DIRECT",
      "device": {
        "init_channel": "internet",
        "ip": await getIPAddress(),
        "user_agent":
            "Mozilla/5.0(WindowsNT10.0;WOW64;rv:51.0)Gecko/20 100101Firefox/51.0",
        "accept_header": "text/html",
        "fingerprintid": "61b12c18b5d0cf901be34a23ca64bb19",
        "browser_tz": "-330",
        "browser_color_depth": "32",
        "browser_java_enabled": "false",
        "browser_screen_height": "601",
        "browser_screen_width": "657",
        "browser_language": "en-US",
        "browser_javascript_enabled": "true"
      }
    };

    // Step 2: Encode JWS Header and Payload
    final String encodedHeader =
        base64Url.encode(utf8.encode(jsonEncode(jwsHeader)));
    final String encodedPayload =
        base64Url.encode(utf8.encode(jsonEncode(payload)));

    // Step 3: Combine JWS Header and Payload with a period ('.')
    final String encodedToken = '$encodedHeader.$encodedPayload';

    // Step 4: Sign the JWS Header and Payload using HMAC-SHA256 with the secret key
    final List<int> bytesToSign = utf8.encode(encodedToken);
    final List<int> secretKeyBytes = utf8.encode(Constants.hmacKey);
    final Hmac hmacSha256 = Hmac(sha256, secretKeyBytes);
    final Digest digest = hmacSha256.convert(bytesToSign);

    // Step 5: Combine the signed JWS Header and Payload with another period ('.')
    final String jwsSignature = base64Url.encode(digest.bytes);
    final String jwsToken = '$encodedToken.$jwsSignature';

    return (jwsToken, payload);
  }

  static String encodeJwt(Map<String, String> headers,
      Map<String, dynamic> payload, String secretKey) {
    // Encode payload
    final String encodedHeader =
        base64UrlEncode(utf8.encode(jsonEncode(headers)));
    final String encodedPayload =
        base64UrlEncode(utf8.encode(jsonEncode(payload)));

    // Create the signature
    final String signatureInput = "$encodedHeader.$encodedPayload";
    final List<int> signature = Hmac(sha256, utf8.encode(secretKey))
        .convert(utf8.encode(signatureInput))
        .bytes;
    final String encodedSignature = base64UrlEncode(signature);

    // Create the JWT
    final String jwt = "$encodedHeader.$encodedPayload.$encodedSignature";
    return jwt;
  }

  static Map<String, dynamic>? decodeJwt(String token) {
    final List<String> parts = token.split('.');
    final String header = parts[0];
    final String payload = parts[1];
    final String signature = parts[2];

    final String encodedHeader = base64Url.normalize(header);
    final String encodedPayload = base64Url.normalize(payload);
    final String encodedSignature = base64Url.normalize(signature);

    final String data = "$encodedHeader.$encodedPayload";

    final List<int> keyBytes = utf8.encode(Constants.hmacKey);
    final List<int> dataBytes = utf8.encode(data);

    final Hmac hmacSha256 = Hmac(sha256, keyBytes);
    final Digest digest = hmacSha256.convert(dataBytes);

    final String signedData = base64Url.encode(digest.bytes);
    print("HERE----> ${signedData == encodedSignature}");
    // if (signedData == encodedSignature) {
      // Signature is valid, proceed with decoding payload
      final String decodedPayload =
          utf8.decode(base64Url.decode(encodedPayload));
      return json.decode(decodedPayload);
    // } else {
    //   return null;
    // }
  }

  static String generateTraceId(int length) {
    const alphanumeric = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    // Generate a random string of the specified length
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => alphanumeric.codeUnitAt(random.nextInt(alphanumeric.length)),
      ),
    );
  }
}
