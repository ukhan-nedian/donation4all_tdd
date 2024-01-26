import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:sign_in/src/domain/entities/User.dart';

abstract class SignInRepository {
  Future<Either<Failure, User>> signIn(String email, String password);
}