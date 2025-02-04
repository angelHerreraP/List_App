import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Pages/routes.dart';
import 'package:meddi/Presentation/buttom_menu.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Routes(
          index: index,
          onButtonPressed: (int i) {
            setState(() {
              index = i;
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            index = 1; // Cambia a la pantalla de Hospitales
          });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.local_hospital, size: 30, color: Colors.white),
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BNavigator(
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
