import 'package:equatable/equatable.dart';

abstract class HospitalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHospitalsEvent extends HospitalEvent {}
