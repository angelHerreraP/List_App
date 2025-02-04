import 'package:flutter/material.dart';
import 'package:meddi/domain/models/hospitals.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailScreen({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hospital.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📌 Imagen principal del hospital
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                hospital.foto,
                fit: BoxFit.cover,
              ),
            ),

            /// 📌 Nombre del hospital
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                hospital.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// 📌 Dirección del hospital
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hospital.direccion,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            /// 📌 Teléfono del hospital
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(
                    hospital.telefono,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            /// 📌 Horario del hospital
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    hospital.horario,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            /// 📌 Botón para abrir Google Maps
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
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
                  icon: const Icon(Icons.map),
                  label: const Text("Ver en Google Maps"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
