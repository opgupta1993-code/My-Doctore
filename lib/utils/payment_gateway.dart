import 'dart:developer';
import 'dart:ui';

import 'package:billDeskSDK/sdk.dart';
import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'package:flutter_hello_my_doctor/controllers/user_controller.dart';
import 'package:flutter_hello_my_doctor/networking/network_calls.dart';
import 'package:flutter_hello_my_doctor/utils/utils.dart';
import 'package:get/get.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentGateway {
  static final UserController _userController = Get.find<UserController>();

  static final Map<String, String> _headers = {
    "alg": "HS256",
    "clientid": Constants.clientId,
    "kid": "HMAC",
  };

  static Future<Map<dynamic, dynamic>?> createOrder(String amount) async {
    final String transactionId = Utils.generateTraceId(35);

    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Create the payload
    final Map<String, dynamic> payload = {
      "mercid": Constants.merchantId,
      "orderid": transactionId,
      "amount": amount,
      "order_date": timestamp,
      "currency": "356",
      // "ru": "https://www.merchant.com/",
      "additional_info": {
        "additional_info1": _userController.user.value.userId,
        "additional_info2": amount,
        "additional_info3": "NA",
        "additional_info4": "NA",
        "additional_info5": "NA",
        "additional_info6": "NA",
        "additional_info7": "NA",
      },
      "itemcode": "DIRECT",
      "device": {
        "init_channel": "internet",
        "ip": "217.21.91.24",
        "accept_header": "text/html",
        "user_agent":
            "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0",
      }
    };

    final String body = Utils.encodeJwt(_headers, payload, Constants.hmacKey);

    // Set headers for HTTP request
    final Map<String, String> httpHeaders = {
      "Content-Type": "application/jose",
      "accept": "application/jose",
      "BD-Traceid": transactionId,
      "BD-Timestamp": "$timestamp",
    };

    // print("TRACE ID ---> $transactionId");

    final Object? response = await NetworkCalls.createOrder(body, httpHeaders);
    // print("RES---> $response");
    if (response == null) return null;

    final Map<String, dynamic>? res = Utils.decodeJwt(response as String);

    return res;
  }

  static Map<String, String> generateBilldeskHeader() {
    final String traceId = Utils.generateTraceId(35);

    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final Map<String, String> httpHeaders = {
      "Content-Type": "application/jose",
      "accept": "application/jose",
      "BD-Traceid": traceId,
      "BD-Timestamp": "$timestamp",
    };

    return httpHeaders;
  }

  static Future<Map<dynamic, dynamic>?> pay({
    required String orderId,
    required String amount,
    required String trnxToken,
  }) async {
    try {
      final Map<dynamic, dynamic>? response =
          await AllInOneSdk.startTransaction(
        Constants.paytmMID,
        orderId,
        amount,
        trnxToken,
        "${Constants.paytmProductionCallbackUrl}$orderId",
        false,
        false,
      );
      return response;
    } catch (err) {
      // print("ERORR :: PaymentGateway :: pay :: $err");
      return null;
    }
  }
}

class SdkResponseHandler extends ResponseHandler {
  Function(TxnInfo txnInfo) onResponse;
  Function(SdkError sdkError) onErrorResponse;

  SdkResponseHandler({required this.onResponse, required this.onErrorResponse});

  @override
  void onTransactionResponse(TxnInfo txnInfo) {
    onResponse(txnInfo);
  }

  @override
  void onError(SdkError sdkError) {
    onErrorResponse(sdkError);
  }
}
