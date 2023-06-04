import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentGateway {
  static Future<void> pay() async {
    try {
      Map<dynamic, dynamic>? response = await AllInOneSdk.startTransaction(
        "Tlgunb64330198288489",
        "1",
        "1",
        "",
        "",
        true,
        false,
      );
    } catch (err) {
      print("ERORR :: PaymentGateway :: pay :: $err");
    }
  }
}
