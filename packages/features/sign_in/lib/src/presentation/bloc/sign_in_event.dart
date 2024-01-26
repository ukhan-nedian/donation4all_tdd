part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class OnSubmitButtonPressed extends SignInEvent {
  final String email;
  final String password;

  const OnSubmitButtonPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
