import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';

abstract class SearchDonorRepository {
  Future<Either<Failure, UserDonor>> searchDonor(String email);
}
