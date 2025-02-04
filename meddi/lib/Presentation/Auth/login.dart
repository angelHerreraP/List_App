import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meddi/Presentation/Auth/register.dart';
import 'package:meddi/Presentation/Pages/App.dart';
import 'package:meddi/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const App()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Column(
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
                    color: Colors.blueAccent.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Form(
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
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildLoginButton(context),
                    _buildRegisterText(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Campo de email
  Widget _buildEmailField() {
    return Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 50),
      child: Center(
        child: TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'Ingresa tu usuario',
            prefixIcon: Icon(Icons.email),
          ),
        ),
      ),
    );
  }

  /// Campo de contraseña
  Widget _buildPasswordField() {
    return Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      child: Center(
        child: TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Ingresa tu contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          obscureText: true,
        ),
      ),
    );
  }

  /// Botón de inicio de sesión con BLoC
  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: state is AuthLoading
                  ? null
                  : () {
                      final username = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      context
                          .read<AuthBloc>()
                          .add(LoginRequested(username, password));
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: state is AuthLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Iniciar sesión',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }

  /// Mensaje y botón "Regístrate"
  Widget _buildRegisterText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: RichText(
        text: TextSpan(
          text: '¿No tienes una cuenta? ',
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Regístrate',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
