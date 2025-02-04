import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meddi/bloc/hospital_event.dart';
import 'package:meddi/bloc/hospital_state.dart';
import 'package:meddi/data/repositories/hospitals_repository.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final HospitalRepository repository;

  HospitalBloc(this.repository) : super(HospitalInitial()) {
    on<FetchHospitalsEvent>(_onFetchHospitals);
  }

  Future<void> _onFetchHospitals(
      FetchHospitalsEvent event, Emitter<HospitalState> emit) async {
    emit(HospitalLoading());
    try {
      final hospitals = await repository.getHospitals();
      print("Se encontraron ${hospitals.length} hospitales."); // Debugging
      emit(HospitalLoaded(hospitals));
    } catch (e) {
      print("Error en HospitalBloc: $e"); // Debugging
      emit(HospitalError("Error al cargar hospitales: $e"));
    }
  }
}
