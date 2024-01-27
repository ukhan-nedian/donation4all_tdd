import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';

abstract class TempDonorRepository {
  Future<Either<Failure, TempDonor>> addTempDonor(
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
  );
}
