import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:temp_donor/src/data/data_sources/temp_donor_remote_data_source.dart';
import 'package:temp_donor/src/domain/repository/temp_donor_repository.dart';

@GenerateMocks([
  TempDonorRepository,
  TempDonorRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
