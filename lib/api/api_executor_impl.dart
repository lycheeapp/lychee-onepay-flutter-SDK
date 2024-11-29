import 'package:dio/dio.dart';
import 'package:lychee_payment_sdk_test/config/config.dart';
import 'package:lychee_payment_sdk_test/payment_sdk.dart';
import 'api_executor.dart';

class ApiExecutorImpl extends ApiExecutor {
  @override
  Future<Response?> onePayPurchases(String code, String amount,
      String deviceUDID, String secretKey, String apiKey) async {
    String payload =
        'amount:${double.parse(amount).toStringAsFixed(2)}${kAppConfig.constData()}code:$code${kAppConfig.constData()}deviceUDID:$deviceUDID';

    String? signature = PaymentSDK.createSignature(payload, secretKey);

    final dio = Dio();

    try {
      final response = await dio.post(
        '${kAppConfig.endpoint()}/pay',
        options: Options(
          headers: {
            'X-API-Key': apiKey,
            'X-Signature': signature,
          },
        ),
        data: {
          "amount": amount,
          "code": code,
          "deviceUDID": deviceUDID,
        },
      );
      // Process the response as needed
      print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      // Handle the DioException and extract the error message
      if (e.response != null) {
        return e.response;
      }
    }
  }
}
