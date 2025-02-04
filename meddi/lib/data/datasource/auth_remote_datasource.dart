import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "https://meddi-training.vercel.app/api/v1";

  /// Iniciar sesión y obtener JWT
  Future<String> loginUser(String username, String password) async {
    final Uri url = Uri.parse("$baseUrl/user/login");

    // 🔹 Debug: Ver qué datos se están enviando
    print("📧 Enviando login con:");
    print("   Usuario: $username");
    print("   Contraseña: ${password.isNotEmpty ? '***' : 'VACÍA'}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    print("🔹 Respuesta de la API: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey("data") && data["data"].containsKey("jwtToken")) {
        print("✅ Login exitoso. Token recibido.");
        return data["data"]["jwtToken"];
      } else {
        throw Exception("Error: No se recibió jwtToken en la respuesta.");
      }
    } else {
      print("❌ Error en el login: ${response.body}");
      throw Exception(
          "Error en el login: ${_extractErrorMessage(response.body)}");
    }
  }

  /// Registrar usuario
  Future<void> registerUser(
      String username, String password, String name, String cellphone) async {
    final Uri url = Uri.parse("$baseUrl/user/create");

    // 🔹 Debug: Ver qué datos se están enviando
    print("📝 Enviando registro con:");
    print("   Usuario: $username");
    print("   Nombre: $name");
    print("   Celular: $cellphone");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "name": name,
        "cellphone": cellphone,
      }),
    );

    print("🔹 Respuesta de la API (Registro): ${response.body}");

    if (response.statusCode != 200) {
      print("❌ Error en el registro: ${response.body}");
      throw Exception(
          "Error en el registro: ${_extractErrorMessage(response.body)}");
    }
  }

  /// Extrae el mensaje de error de la respuesta de la API
  String _extractErrorMessage(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      if (data.containsKey("message")) {
        return data["message"];
      }
      return "Error desconocido.";
    } catch (_) {
      return "Error al procesar la respuesta del servidor.";
    }
  }
}
