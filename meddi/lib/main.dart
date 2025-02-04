import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meddi/Presentation/Pages/Splashscreen.dart';
import 'package:meddi/bloc/auth_bloc.dart';
import 'package:meddi/bloc/hospital_bloc.dart';
import 'package:meddi/bloc/hospital_event.dart'; // Asegúrate de importarlo
import 'package:meddi/core/storage/secure_storage.dart';
import 'package:meddi/data/datasource/auth_remote_datasource.dart';
import 'package:meddi/data/datasource/hospital_remote_datasource.dart';
import 'package:meddi/data/repositories/auth_repository_impl.dart';
import 'package:meddi/data/repositories/hospitals_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepositoryImpl(
              AuthRemoteDataSource(),
              SecureStorage(),
            ),
          ),
        ),
        BlocProvider<HospitalBloc>(
          create: (context) => HospitalBloc(
            HospitalRepository(
                HospitalRemoteDataSource()), // 🔥 Pasamos el repositorio
          )..add(
              FetchHospitalsEvent()), // 🔥 Disparamos el evento al crear el Bloc
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
