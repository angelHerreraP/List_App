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
                padding: const EdgeInsets.all(10),
                itemCount: state.hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = state.hospitals[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HospitalDetailScreen(hospital: hospital),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(hospital.foto),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              hospital.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              hospital.direccion,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
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
