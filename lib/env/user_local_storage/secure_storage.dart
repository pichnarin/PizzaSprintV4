import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage {
  static const secureStorage = FlutterSecureStorage();

  Future<void> persistentToken(String token) async {
    await secureStorage.write(key: 'jwt_token', value: token);
  }

  Future<String?> retrieveToken() async {
    return await secureStorage.read(key: 'jwt_token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'jwt_token');
  }
}

final secureLocalStorage = SecureLocalStorage();