part of 'temp_donor_bloc.dart';

abstract class TempDonorState extends Equatable {
  const TempDonorState();
}

class TempDonorInitial extends TempDonorState {
  @override
  List<Object> get props => [];
}

class AddingTempDonor extends TempDonorState {
  @override
  List<Object> get props => [];
}

class TempDonorAdded extends TempDonorState {
  final TempDonor tempDonor;

  const TempDonorAdded({required this.tempDonor});

  @override
  List<Object> get props => [tempDonor];
}

class TempDonorNotAdded extends TempDonorState {
  final String errorMessage;

  const TempDonorNotAdded({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
