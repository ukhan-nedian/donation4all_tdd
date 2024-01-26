import 'package:search_donor/src/domain/entities/UserDonor.dart';

abstract class SearchDonorRemoteDataSource {
  Future<UserDonor> searchDonor(String email);
}