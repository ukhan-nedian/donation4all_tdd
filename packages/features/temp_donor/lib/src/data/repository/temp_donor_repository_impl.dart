import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:temp_donor/src/data/data_sources/temp_donor_remote_data_source.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:temp_donor/src/domain/repository/temp_donor_repository.dart';

class TempDonorRepositoryImpl extends TempDonorRepository {
  final TempDonorRemoteDataSource tempDonorRemoteDataSource;

  TempDonorRepositoryImpl({required this.tempDonorRemoteDataSource});

  @override
  Future<Either<Failure, TempDonor>> addTempDonor(
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
  ) async {
    try {
      final result = await tempDonorRemoteDataSource.addTempDonor(
        firstName,
        lastName,
        email,
        password,
        mobile,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect'));
    } on ApiException catch (e) {
      return Left(ApiFailure(e.errorMessage));
    }
  }
}
