import 'package:flutter_hello_my_doctor/constants/constants.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentGateway {
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
