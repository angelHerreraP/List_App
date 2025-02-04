import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meddi/Presentation/Pages/Splashscreen.dart';
import 'package:meddi/bloc/auth_bloc.dart';
import 'package:meddi/bloc/hospital_bloc.dart';
import 'package:meddi/bloc/hospital_event.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HospitalRepository>(
          create: (context) => HospitalRepository(HospitalRemoteDataSource()),
        ),
      ],
      child: MultiBlocProvider(
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
              RepositoryProvider.of<HospitalRepository>(context),
            )..add(FetchHospitalsEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splashscreen(),
        ),
      ),
    );
  }
}
