import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "https://meddi-training.vercel.app/api/v1";

  /// Iniciar sesión
  Future<String> loginUser(String username, String password) async {
    final Uri url = Uri.parse("$baseUrl/user/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    print(
        "🔹 Respuesta de la API: ${response.body}"); // 🔥 Ver qué devuelve la API

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // ✅ Cambiamos "accessToken" por "jwtToken"
      if (data.containsKey("data") && data["data"].containsKey("jwtToken")) {
        return data["data"]["jwtToken"];
      } else {
        throw Exception("Error: No se recibió jwtToken en la respuesta.");
      }
    } else {
      throw Exception("Error en el login: ${response.body}");
    }
  }

  /// Registrar usuario
  Future<void> registerUser(
      String username, String password, String name, String cellphone) async {
    final Uri url = Uri.parse("$baseUrl/user/create");

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

    if (response.statusCode != 200) {
      throw Exception("Error en el registro: ${response.body}");
    }
  }
}
