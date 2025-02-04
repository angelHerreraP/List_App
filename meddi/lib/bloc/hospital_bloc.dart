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
    try {
      emit(HospitalLoading());
      final hospitals = await repository.getHospitals();
      emit(HospitalLoaded(hospitals));
    } catch (e) {
      emit(HospitalError("Error al cargar hospitales: ${e.toString()}"));
    }
  }
}
