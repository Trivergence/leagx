import 'package:bailbooks_defendant/core/network/config/app_urls.dart';
import 'package:bailbooks_defendant/core/network/config/base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost => AppUrls.baseUrlDev;

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => true;
}
