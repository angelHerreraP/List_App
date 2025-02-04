import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";

  /// Guarda el token en almacenamiento seguro
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Obtiene el token JWT almacenado
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Elimina el token JWT (Logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
