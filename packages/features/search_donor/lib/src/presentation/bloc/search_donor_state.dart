part of 'search_donor_bloc.dart';

abstract class SearchDonorState extends Equatable {
  const SearchDonorState();
}

class SearchDonorInitial extends SearchDonorState {
  @override
  List<Object> get props => [];
}

class SearchingDonor extends SearchDonorState {
  @override
  List<Object> get props => [];
}

class DonorFound extends SearchDonorState {
  final UserDonor userDonor;

  const DonorFound({required this.userDonor});

  @override
  List<Object> get props => [userDonor];
}

class DonorNotFound extends SearchDonorState {
  final String errorMessage;

  const DonorNotFound({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
