import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meddi/bloc/hospital_bloc.dart';
import 'package:meddi/bloc/hospital_event.dart';
import 'package:meddi/bloc/hospital_state.dart';
import 'package:meddi/domain/models/hospitals.dart';

class HospitalesMapa extends StatefulWidget {
  @override
  _HospitalesMapaState createState() => _HospitalesMapaState();
}

class _HospitalesMapaState extends State<HospitalesMapa> {
  late GoogleMapController _mapController;

  // ✅ Posición inicial correcta
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(20.6597, -103.3496), // 📍 Guadalajara
    zoom: 12.0,
  );

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    context.read<HospitalBloc>().add(FetchHospitalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa de Hospitales")),
      body: BlocBuilder<HospitalBloc, HospitalState>(
        builder: (context, state) {
          if (state is HospitalLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is HospitalLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _setMarkers(state.hospitals);
            });

            return GoogleMap(
              initialCameraPosition: _initialPosition,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
            );
          }

          if (state is HospitalError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }

  void _setMarkers(List<Hospital> hospitals) {
    setState(() {
      _markers.clear();
      _markers.addAll(hospitals.map((hospital) => Marker(
        markerId: MarkerId(hospital.id),
        position: LatLng(hospital.latitud, hospital.longitud),
        infoWindow: InfoWindow(title: hospital.name),
      )));
    });

  }
}
