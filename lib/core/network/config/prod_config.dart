import 'package:leagx/core/network/config/app_urls.dart';
import 'package:leagx/core/network/config/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => AppUrls.baseUrlProd;

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => true;
}
