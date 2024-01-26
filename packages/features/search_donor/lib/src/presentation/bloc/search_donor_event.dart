part of 'search_donor_bloc.dart';

abstract class SearchDonorEvent extends Equatable {
  const SearchDonorEvent();
}

class OnSubmitButtonPressed extends SearchDonorEvent {
  final String email;

  const OnSubmitButtonPressed({required this.email});

  @override
  List<Object?> get props => [email];
}
