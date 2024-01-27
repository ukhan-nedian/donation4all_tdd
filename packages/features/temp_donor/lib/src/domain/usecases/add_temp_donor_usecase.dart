import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:temp_donor/src/domain/repository/temp_donor_repository.dart';

class AddTempDonorUsecase {
  final TempDonorRepository tempDonorRepository;

  AddTempDonorUsecase({required this.tempDonorRepository});

  Future<Either<Failure, TempDonor>> execute(
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
  ) async {
    return await tempDonorRepository.addTempDonor(
      firstName,
      lastName,
      email,
      password,
      mobile,
    );
  }
}
