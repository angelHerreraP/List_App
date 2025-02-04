import 'package:meddi/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  /// Ejecuta el registro del usuario
  Future<void> call(
      String username, String password, String name, String cellphone) async {
    return await repository.register(username, password, name, cellphone);
  }
}
