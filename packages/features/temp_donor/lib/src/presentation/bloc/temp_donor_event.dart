part of 'temp_donor_bloc.dart';

abstract class TempDonorEvent extends Equatable {
  const TempDonorEvent();
}

class OnSubmitButtonPressed extends TempDonorEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobile;

  const OnSubmitButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobile,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password, mobile];
}
