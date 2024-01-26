import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:search_donor/src/domain/usecases/search_donor_usecase.dart';

part 'search_donor_event.dart';

part 'search_donor_state.dart';

class SearchDonorBloc extends Bloc<SearchDonorEvent, SearchDonorState> {
  final SearchDonorUsecase searchDonorUsecase;

  SearchDonorBloc({required this.searchDonorUsecase})
      : super(SearchDonorInitial()) {
    on<OnSubmitButtonPressed>(
      (event, emit) async {
        emit(SearchingDonor());
        final result = await searchDonorUsecase.execute(event.email);
        result.fold(
          (failure) => emit(DonorNotFound(errorMessage: failure.message)),
          (userDonor) => emit(DonorFound(userDonor: userDonor)),
        );
      },
    );
  }
}
