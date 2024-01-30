import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:temp_donor/src/data/data_sources/temp_donor_remote_data_source.dart';
import 'package:temp_donor/src/domain/repository/temp_donor_repository.dart';
import 'package:temp_donor/src/domain/usecases/add_temp_donor_usecase.dart';

@GenerateMocks([
  TempDonorRepository,
  TempDonorRemoteDataSource,
  AddTempDonorUsecase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
