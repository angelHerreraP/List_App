import 'package:equatable/equatable.dart';
import 'package:meddi/domain/models/hospitals.dart';

abstract class HospitalState extends Equatable {
  @override
  List<Object> get props => [];
}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<Hospital> hospitals;

  HospitalLoaded(this.hospitals);

  @override
  List<Object> get props => [hospitals];
}

class HospitalError extends HospitalState {
  final String message;

  HospitalError(this.message);

  @override
  List<Object> get props => [message];
}
