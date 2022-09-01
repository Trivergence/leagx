import 'package:leagx/core/network/config/base_config.dart';
import 'package:leagx/core/network/config/dev_config.dart';
import 'package:leagx/core/network/config/prod_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String dev = 'dev';
  static const String prod = 'prod';

  late BaseConfig config;
  static late String type;

  initConfig(String environment) {
    type = environment;
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.prod:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
