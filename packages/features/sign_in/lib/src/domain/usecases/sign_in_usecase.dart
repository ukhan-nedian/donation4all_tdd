import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:sign_in/src/domain/repository/sign_in_repository.dart';

class SignInUsecase {
  final SignInRepository signInRepository;

  SignInUsecase(this.signInRepository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return signInRepository.signIn(email, password);
  }
}
