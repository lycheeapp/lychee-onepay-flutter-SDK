import 'dev/dev_config.dart';
import 'prod/prod_config.dart';

const AppConfig kAppConfig = DevAppConfig();

/// DevAppConfig
///
/// StagingAppConfig
///
/// ProdAppConfig

abstract class AppConfig {
  const AppConfig();

  String endpoint();
  String constData();
}
