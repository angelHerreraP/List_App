import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meddi/core/storage/secure_storage.dart'; // Importamos SecureStorage
import 'package:meddi/domain/models/hospitals.dart';

class HospitalRemoteDataSource {
  final String baseUrl = "https://meddi-training.vercel.app/api/v1";
  final SecureStorage secureStorage =
      SecureStorage(); // Instancia de SecureStorage

  Future<List<Hospital>> fetchHospitals() async {
    final Uri url = Uri.parse(
        "$baseUrl/hospital/get/all?page=1&rowsPerPage=10&lat=20.7244704&long=-103.397476&estadoCode=JC");

    // Recuperamos el token almacenado
    final String? token = await secureStorage.getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Error: No se encontró un token almacenado.");
    }

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token" // Insertamos el token recuperado
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> hospitalList = data["data"]["data"];
      return hospitalList.map((json) => Hospital.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener hospitales: ${response.body}");
    }
  }
}
