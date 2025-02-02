import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Auth/register.dart';

//import '/App.dart';
//import '/Loggeo/newAccount.dart';
//import '/Loggeo/password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible =
      false; // Control para mostrar u ocultar la contraseña

  // Función para iniciar sesión (puedes agregar la lógica aquí)
  void _login() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica de autenticación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando sesión...')),
      );
      // Ejemplo de navegación a la pantalla principal después de iniciar sesión
      //Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => const App()),
      //);
    }
  }

  // Función para ir a la pantalla de registro
  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 30),
                    child: const Text(
                      'Inicia Sesión',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu usuario',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu usuario';
                          }
                          if (!value.contains('@')) {
                            return 'Por favor, ingresa un email válido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText:
                            !_isPasswordVisible, // Muestra u oculta la contraseña
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black, // Color de fondo del botón
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style:
                              TextStyle(color: Colors.white), // Color del texto
                        ),
                      ),
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: '¿No tienes una cuenta? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Regístrate',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _navigateToRegister,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
