import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:search_donor/src/data/data_sources/search_donor_remote_data_source.dart';
import 'package:search_donor/src/domain/repository/search_donor_repository.dart';
import 'package:search_donor/src/domain/usecases/search_donor_usecase.dart';

@GenerateMocks([
  SearchDonorRepository,
  SearchDonorRemoteDataSource,
  SearchDonorUsecase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
