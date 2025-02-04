import 'package:meddi/core/storage/secure_storage.dart';
import 'package:meddi/data/datasource/auth_remote_datasource.dart';
import 'package:meddi/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

  @override
  Future<void> login(String username, String password) async {
    try {
      final token = await remoteDataSource.loginUser(username, password);

      if (token.isNotEmpty) {
        await secureStorage.saveToken(token); // ✅ Guarda el token correctamente
      } else {
        throw Exception("Error: No se recibió un token válido.");
      }
    } catch (e) {
      throw Exception("Error al iniciar sesión: $e");
    }
  }

  @override
  Future<void> logout() async {
    await secureStorage.deleteToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await secureStorage.getToken();
      return token != null && token.isNotEmpty; // ✅ Verifica si el token existe
    } catch (e) {
      return false; // En caso de error, asumimos que el usuario no está logueado
    }
  }

  @override
  Future<void> register(
      String username, String password, String name, String cellphone) async {
    try {
      await remoteDataSource.registerUser(username, password, name, cellphone);
    } catch (e) {
      throw Exception("Error al registrar usuario: $e");
    }
  }
}
