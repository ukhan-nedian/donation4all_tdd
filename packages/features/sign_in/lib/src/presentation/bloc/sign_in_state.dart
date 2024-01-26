part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SigningIn extends SignInState {
  @override
  List<Object> get props => [];
}

class SignedIn extends SignInState {
  final User user;

  const SignedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class NotSignedIn extends SignInState {
  final String errorMessage;

  const NotSignedIn({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
