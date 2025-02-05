import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Pages/hospital_screen.dart';
import 'package:meddi/Presentation/Pages/hospitals_map.dart';

class Routes extends StatelessWidget {
  final int index;
  final Function(int) onButtonPressed;

  const Routes({Key? key, required this.index, required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      HospitalScreen(), // Pantalla de Hospitales
      HospitalesMapa(), // Página de inicio
      const Center(child: Text('Pantalla de Contacto')), // Pantalla de Contacto
    ];
    return myList[index];
  }
}
