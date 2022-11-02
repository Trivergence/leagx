part of payments;

class StripeConfig {
  static final StripeConfig _singleton = StripeConfig._internal();

  factory StripeConfig() {
    return _singleton;
  }

  StripeConfig._internal();

  String _secretkey = '';

  String get getSecretKey => _secretkey;

  void setSecretkey({required String key}) {
    _secretkey = key;
  }
}
