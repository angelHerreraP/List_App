import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meddi/Presentation/Auth/register.dart';
import 'package:meddi/Presentation/Pages/App.dart';
import 'package:meddi/core/storage/secure_storage.dart';
import 'package:meddi/data/datasource/auth_remote_datasource.dart';
import 'package:meddi/data/repositories/auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Inyectar dependencias
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl(
    AuthRemoteDataSource(),
    SecureStorage(),
  );

  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  /// Verifica si el usuario ya está autenticado al abrir la app
  void _checkLoginStatus() async {
    final bool loggedIn = await authRepository.isLoggedIn();
    if (loggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    }
  }

  /// Función para manejar el login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final username = _emailController.text.trim();
        final password = _passwordController.text.trim();

        // 🔹 Validar antes de enviar la solicitud
        if (username.isEmpty || !username.contains('@')) {
          throw Exception("El usuario debe ser un email válido.");
        }
        if (password.isEmpty) {
          throw Exception("La contraseña no puede estar vacía.");
        }

        print("📧 Enviando login con usuario: '$username'");
        print(
            "🔑 Enviando password: '${password.isNotEmpty ? '***' : 'VACÍA'}'");

        await authRepository.login(username, password);

        final String? token = await secureStorage.getToken();
        print("🔹 Token almacenado: $token");

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const App()),
          );
        }
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
  }

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
                  _buildLoginButton(),
                  _buildRegisterText(),
                ],
              ),
            ),
          ),
        ],
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
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          obscureText: !_isPasswordVisible,
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
    );
  }

  /// Botón de inicio de sesión con loading
  Widget _buildLoginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: 250,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }

  /// Mensaje y botón "Regístrate"
  Widget _buildRegisterText() {
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
              recognizer: TapGestureRecognizer()..onTap = _navigateToRegister,
            ),
          ],
        ),
      ),
    );
  }
}
