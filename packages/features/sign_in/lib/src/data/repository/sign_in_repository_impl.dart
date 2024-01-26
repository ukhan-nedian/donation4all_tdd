import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:sign_in/src/data/data_sources/sign_in_remote_data_source.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:sign_in/src/domain/repository/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDataSource signInRemoteDataSource;

  SignInRepositoryImpl(this.signInRemoteDataSource);

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final result = await signInRemoteDataSource.signIn(email, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
