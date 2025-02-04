import 'package:flutter/material.dart';
import 'package:meddi/domain/models/hospitals.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailScreen({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(hospital.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Imagen principal con efecto sombra
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    hospital.foto,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Información en una tarjeta flotante
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Nombre del hospital
                  Text(
                    hospital.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  /// Dirección
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          hospital.direccion,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Teléfono con botón de llamada
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        hospital.telefono,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () async {
                          final Uri url = Uri.parse("tel:${hospital.telefono}");
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Horario
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.orange, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        hospital.horario,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Botón "Ver en Google Maps"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.map, size: 24),
                  label: const Text(
                    "Ver en Google Maps",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    final Uri url = Uri.parse(hospital.urlGoogleMaps);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("No se pudo abrir el enlace")),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
