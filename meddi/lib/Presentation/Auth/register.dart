import 'package:flutter/material.dart';
import 'package:meddi/core/storage/secure_storage.dart';
import 'package:meddi/data/datasource/auth_remote_datasource.dart';
import 'package:meddi/data/repositories/auth_repository_impl.dart';
import 'package:meddi/domain/usecases/register_user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Inyectamos el caso de uso
  final RegisterUser registerUser = RegisterUser(
    AuthRepositoryImpl(
      AuthRemoteDataSource(),
      SecureStorage(),
    ),
  );

  /// Función para registrar usuario con validaciones
  void _register() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return; // Evita continuar si el formulario no es válido
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final username = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final cellphone = _phoneController.text.trim();

      if (username.isEmpty ||
          password.isEmpty ||
          name.isEmpty ||
          cellphone.isEmpty) {
        throw Exception("Todos los campos son obligatorios.");
      }

      await registerUser.call(username, password, name, cellphone);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro exitoso. Inicia sesión.")),
      );

      Navigator.pop(context); // Volver al login después del registro
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 30),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: 350,
            height: 500,
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 30),
                    child: const Text(
                      'Regístrate',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildTextField(
                      _nameController, "Ingresa tu Nombre", Icons.person),
                  _buildTextField(
                      _emailController, "Ingresa tu Correo", Icons.email),
                  _buildTextField(
                      _phoneController, "Ingresa tu Celular", Icons.phone),
                  _buildTextField(
                      _passwordController, "Ingresa tu Contraseña", Icons.lock,
                      isPassword: true),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget para campos de entrada de texto
  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPassword = false}) {
    return Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      child: Center(
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Por favor, $hint";
            }
            return null;
          },
        ),
      ),
    );
  }

  /// Botón de registro con loading
  Widget _buildRegisterButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: 250,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _register,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Registrarse'),
        ),
      ),
    );
  }
}
