import 'package:dio/dio.dart';

import 'api_executor_impl.dart';

abstract class ApiExecutor {
  static ApiExecutor? _instance;

  static ApiExecutor getInstance() {
    return _instance ??= ApiExecutorImpl();
  }

  ApiExecutor();

  Future<Response?> onePayPurchases(String code, String amount, String deviceUDID,
      String secretKey, String apiKey);
}
