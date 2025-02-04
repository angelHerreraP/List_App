// app.dart
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Pantalla de Inicio'));
      case 1:
        return const Center(child: Text('Pantalla de Hospitales'));
      default:
        return const Center(child: Text('Pantalla por Defecto'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(index),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            index = 1; // Cambia a la pantalla de la cámara
          });
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.local_hospital,
            size: 30, color: Colors.blueAccent),
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigator(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
      ),
    );
  }
}

// custom_bottom_navigator.dart
class CustomBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Botón Inicio
            IconButton(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.blueAccent : Colors.grey,
              ),
              onPressed: () => onTap(0),
            ),
            // Espacio para el botón central
            const SizedBox(width: 40),
            // Botón Información
            IconButton(
              icon: Icon(
                Icons.info,
                color: currentIndex == 2 ? Colors.blueAccent : Colors.grey,
              ),
              onPressed: () => onTap(2),
            ),
          ],
        ),
      ),
    );
  }
}
