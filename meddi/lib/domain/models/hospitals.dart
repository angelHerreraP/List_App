class Hospital {
  final String id;
  final String name;
  final String logo;
  final String foto;
  final String direccion;
  final String urlGoogleMaps;
  final String telefono;
  final String horario;
  final String municipio;
  final double latitud;
  final double longitud;

  Hospital({
    required this.id,
    required this.name,
    required this.logo,
    required this.foto,
    required this.direccion,
    required this.urlGoogleMaps,
    required this.telefono,
    required this.horario,
    required this.municipio,
    required this.latitud,
    required this.longitud,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    List<dynamic>? coordinates = json["location"]?["coordinates"];

    if (coordinates == null || coordinates.length < 2) {
      throw Exception("Error: No se encontraron coordenadas en la API.");
    }

    return Hospital(
      id: json["_id"],
      name: json["name"],
      logo: json["logo"] ?? "",
      foto: json["foto"] ?? "",
      direccion: json["direccion"] ?? "",
      urlGoogleMaps: json["urlGoogleMaps"] ?? "",
      telefono: json["telefono"] ?? "No disponible",
      horario: json["horario"] ?? "No especificado",
      municipio: json["municipio"] ?? "No disponible",
      latitud: coordinates[1].toDouble(),
      longitud: coordinates[0].toDouble(),
    );
  }
}
g