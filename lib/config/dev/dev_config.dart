import '../config.dart';

/// Dev.
class DevAppConfig extends AppConfig {
  const DevAppConfig();

  @override
  String endpoint() {
    return 'https://apitest.lycheeapp.org/rest/lychee-v2/public/one-pay';
  }

  @override
  String constData() {
    return "\$\$\$";
  }
}
