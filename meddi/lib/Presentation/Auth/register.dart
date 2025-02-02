import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  final List<String> days =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> months =
      List.generate(12, (index) => (index + 1).toString());
  final List<String> years =
      List.generate(101, (index) => (2023 - index).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 20, top: 30), // Margen para el botón "Volver"
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Aquí va la lógica para regresar a la pantalla anterior
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
                      'Regístrate',
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu Nombre',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu Nombre';
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu Correo',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu Correo';
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
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu Contraseña',
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu Contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // Dropdown para día, mes y año
                  Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: selectedDay,
                          hint: const Text('Día'),
                          items: days.map((String day) {
                            return DropdownMenuItem<String>(
                              value: day,
                              child: Text(day),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDay = newValue!;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          value: selectedMonth,
                          hint: const Text('Mes'),
                          items: months.map((String month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          value: selectedYear,
                          hint: const Text('Año'),
                          items: years.map((String year) {
                            return DropdownMenuItem<String>(
                              value: year,
                              child: Text(year),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedYear = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Botón para registrarse
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 250, // Ancho del botón
                      height: 50, // Alto del botón
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Aquí va la lógica para registrarse
                          }
                        },
                        child: const Text('Registrarse'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50), // Tamaño del botón
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
