import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Auth/login.dart';
import 'package:meddi/Presentation/Auth/register.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Dos pestañas: Login y Registro
      child: Scaffold(
        appBar: AppBar(
          title: Text("Autenticación"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Iniciar Sesión"),
              Tab(text: "Registrarse"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreen(),  // Página de Login
            RegisterScreen(),  // Página de Registro
          ],
        ),
      ),
    );
  }
}
