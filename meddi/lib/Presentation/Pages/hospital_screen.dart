import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meddi/bloc/hospital_bloc.dart';
import 'package:meddi/bloc/hospital_event.dart';
import 'package:meddi/bloc/hospital_state.dart';
import 'package:meddi/data/repositories/hospitals_repository.dart';
import 'package:meddi/presentation/pages/hospital_detail_screen.dart';

class HospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hospitales")),
      body: BlocProvider(
        create: (context) => HospitalBloc(
          RepositoryProvider.of<HospitalRepository>(context),
        )..add(FetchHospitalsEvent()), // Lanzar el evento al iniciar
        child: BlocBuilder<HospitalBloc, HospitalState>(
          builder: (context, state) {
            if (state is HospitalLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HospitalLoaded) {
              return ListView.builder(
                itemCount: state.hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = state.hospitals[index];
                  return ListTile(
                    leading:
                        Image.network(hospital.logo, width: 50, height: 50),
                    title: Text(hospital.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HospitalDetailScreen(hospital: hospital),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is HospitalError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("No hay hospitales disponibles"));
            }
          },
        ),
      ),
    );
  }
}
