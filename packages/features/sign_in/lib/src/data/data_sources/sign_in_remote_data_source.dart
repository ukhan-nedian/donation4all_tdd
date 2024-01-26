import 'package:sign_in/src/domain/entities/User.dart';

abstract class SignInRemoteDataSource {
  Future<User> signIn(String email, String password);
}
