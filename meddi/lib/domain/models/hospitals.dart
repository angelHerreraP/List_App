class Hospital {
  final String id;
  final String name;
  final String foto;
  final String logo;
  final String direccion;
  final String telefono;
  final String horario;
  final String urlGoogleMaps;

  Hospital({
    required this.id,
    required this.name,
    required this.foto,
    required this.logo,
    required this.direccion,
    required this.telefono,
    required this.horario,
    required this.urlGoogleMaps,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      foto: json["foto"] ?? "",
      logo: json["logo"] ?? "",
      direccion: json["direccion"] ?? "",
      telefono: json["telefono"] ?? "",
      horario: json["horario"] ?? "",
      urlGoogleMaps: json["urlGoogleMaps"] ?? "",
    );
  }
}
