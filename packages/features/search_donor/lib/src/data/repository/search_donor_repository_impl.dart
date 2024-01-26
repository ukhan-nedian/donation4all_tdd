import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:search_donor/src/data/data_sources/search_donor_remote_data_source.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:search_donor/src/domain/repository/search_donor_repository.dart';

class SearchDonorRepositoryImpl implements SearchDonorRepository {
  final SearchDonorRemoteDataSource searchDonorRemoteDataSource;

  SearchDonorRepositoryImpl({required this.searchDonorRemoteDataSource});

  @override
  Future<Either<Failure, UserDonor>> searchDonor(String email) async {
    try {
      final result = await searchDonorRemoteDataSource.searchDonor(email);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ApiException catch (e) {
      return Left(ApiFailure(e.errorMessage));
    }
  }
}
