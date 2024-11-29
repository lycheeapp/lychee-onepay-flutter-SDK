import '../config.dart';

/// Prod.
class ProdAppConfig extends AppConfig {
  const ProdAppConfig();

  @override
  String endpoint() {
    return 'http://prod.lycheecoin.org/rest/lychee-v2/public/one-pay/';
  }

  @override
  String constData() {
    return "\$\$\$";
  }
}
