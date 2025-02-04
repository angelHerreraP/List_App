import 'package:meddi/data/datasource/hospital_remote_datasource.dart';
import 'package:meddi/domain/models/hospitals.dart';

class HospitalRepository {
  final HospitalRemoteDataSource remoteDataSource;

  HospitalRepository(this.remoteDataSource);

  Future<List<Hospital>> getHospitals() async {
    return await remoteDataSource.fetchHospitals();
  }
}
