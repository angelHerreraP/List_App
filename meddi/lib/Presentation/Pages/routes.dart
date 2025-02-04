import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Pages/hospital_screen.dart';

class Routes extends StatelessWidget {
  final int index;
  final Function(int) onButtonPressed;

  const Routes({Key? key, required this.index, required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      const Center(child: Text('Pantalla de Inicio')), // Página de inicio
      HospitalScreen(), // Pantalla de Hospitales
      const Center(child: Text('Pantalla de Contacto')), // Pantalla de Contacto
    ];
    return myList[index];
  }
}
