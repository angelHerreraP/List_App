import 'package:flutter/material.dart';

class BNavigator extends StatefulWidget {
  final Function(int)
      currentIndex; // Función para comunicar el índice seleccionado
  const BNavigator({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BNavigator> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  // Índice para el botón seleccionado
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.blueAccent, // Color de botón seleccionado
      unselectedItemColor:
          Colors.blueAccent[200], // Color de botones no seleccionados
      selectedFontSize: 15,
      unselectedFontSize: 12,
      onTap: (int i) {
        setState(() {
          index = i; // Actualiza el índice local
          widget.currentIndex(i); // Notifica al widget padre
        });
      },
      type: BottomNavigationBarType.fixed, // Mantiene todos los íconos visibles
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), label: 'Hospitales'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Contacto'),
      ],
    );
  }
}
