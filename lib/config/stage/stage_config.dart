import '../config.dart';

/// Staging.
class StagingAppConfig extends AppConfig {
  const StagingAppConfig();
  @override
  String endpoint() {
    return '';
  }

  @override
  String constData() {
    return "\$\$\$";
  }
}
