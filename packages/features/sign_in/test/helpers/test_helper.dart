import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:sign_in/src/data/data_sources/sign_in_remote_data_source.dart';
import 'package:sign_in/src/domain/repository/sign_in_repository.dart';
import 'package:sign_in/src/domain/usecases/sign_in_usecase.dart';

@GenerateMocks([
  SignInRepository,
  SignInRemoteDataSource,
  SignInUsecase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
