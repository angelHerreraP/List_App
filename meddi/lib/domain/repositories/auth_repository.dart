abstract class AuthRepository {
  /// Iniciar sesión con email y contraseña, devuelve un Future<void>
  Future<void> login(String username, String password);

  /// Cerrar sesión (eliminar token)
  Future<void> logout();

  /// Verifica si el usuario tiene sesión activa
  Future<bool> isLoggedIn();

  Future<void> register(
      String username, String password, String name, String cellphone);
}
