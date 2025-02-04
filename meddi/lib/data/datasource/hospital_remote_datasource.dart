import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meddi/core/storage/secure_storage.dart';
import 'package:meddi/domain/models/hospitals.dart';

class HospitalRemoteDataSource {
  final String baseUrl = "https://meddi-training.vercel.app/api/v1";
  final SecureStorage secureStorage =
      SecureStorage(); // Instancia de SecureStorage

  Future<List<Hospital>> fetchHospitals() async {
    final String? token = await secureStorage.getToken();

    if (token == null) {
      throw Exception("Token no encontrado, por favor inicia sesión.");
    }

    final Uri url = Uri.parse(
        "$baseUrl/hospital/get/all?page=1&rowsPerPage=10&lat=20.7244704&long=-103.397476&estadoCode=JC");

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
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
