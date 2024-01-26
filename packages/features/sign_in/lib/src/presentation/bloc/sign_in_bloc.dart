import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:sign_in/src/domain/usecases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUsecase signInUsecase;

  SignInBloc(this.signInUsecase) : super(SignInInitial()) {
    on<OnSubmitButtonPressed>(
      (event, emit) async {
        emit(SigningIn());
        final result = await signInUsecase.execute(event.email, event.password);
        result.fold(
          (failure) => emit(NotSignedIn(errorMessage: failure.message)),
          (user) => emit(SignedIn(user: user)),
        );
      },
    );
  }
}
