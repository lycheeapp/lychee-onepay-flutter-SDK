import 'package:dio/dio.dart';
import 'package:lychee_payment_sdk_test/api/api_executor.dart';

class AppRepo {
  static AppRepo? _instance;

  static AppRepo instance() => _instance ??= AppRepo._();

  AppRepo._();

  final ApiExecutor apiExecutor = ApiExecutor.getInstance();

  Future<Response?> onePayPurchases(String code, String amount,
      String deviceUDID, String secretKey, String apiKey) async {
    return apiExecutor.onePayPurchases(
        code, amount, deviceUDID, secretKey, apiKey);
  }
}
