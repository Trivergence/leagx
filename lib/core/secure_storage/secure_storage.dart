import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leagx/core/secure_storage/constants/secure_keys.dart';

class SecureStore {
  FlutterSecureStorage secureStorage;
  SecureStore(this.secureStorage);

  Future<void> saveCustomerId(String id) async {
    await secureStorage.write(key: SecureKeys.customerId, value: id);
  }
  Future<String?> getCustomerId() async {
    String? id = await secureStorage.read(key: SecureKeys.customerId);
    return id;
  }
}