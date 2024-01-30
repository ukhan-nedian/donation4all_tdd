import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:temp_donor/src/domain/usecases/add_temp_donor_usecase.dart';

part 'temp_donor_event.dart';
part 'temp_donor_state.dart';

class TempDonorBloc extends Bloc<TempDonorEvent, TempDonorState> {
  final AddTempDonorUsecase addTempDonorUsecase;

  TempDonorBloc({required this.addTempDonorUsecase})
      : super(TempDonorInitial()) {
    on<OnSubmitButtonPressed>((event, emit) async {
      emit(AddingTempDonor());
      final result = await addTempDonorUsecase.execute(
        event.firstName,
        event.lastName,
        event.email,
        event.password,
        event.mobile,
      );
      result.fold(
        (failure) => emit(TempDonorNotAdded(errorMessage: failure.message)),
        (tempDonor) => emit(TempDonorAdded(tempDonor: tempDonor)),
      );
    });
  }
}
