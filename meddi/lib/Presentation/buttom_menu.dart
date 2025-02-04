import 'package:flutter/material.dart';

class BNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BNavigator({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.blueAccent, // Color de botón seleccionado
      unselectedItemColor:
          Colors.blueAccent[200], // Color de botones no seleccionados
      selectedFontSize: 15,
      unselectedFontSize: 12,
      onTap: onTap,
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
