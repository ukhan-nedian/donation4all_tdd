import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:sign_in/src/presentation/bloc/sign_in_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSignInUsecase mockSignInUsecase;
  late SignInBloc signInBloc;

  setUp(() {
    mockSignInUsecase = MockSignInUsecase();
    signInBloc = SignInBloc(mockSignInUsecase);
  });

  final User testUser = User(
    userId: 52,
    name: null,
    email: "newuser1@gmail.com",
    password: "\$2b\$12\$hxlPcdq.Iu4EEL0IPGtUm.JtonHHXF1MnY5XnwkAAA7NRtBF4fkW6",
    phone: "+15166184623",
    userType: "D",
    loginType: "mobile",
    isActive: 1,
    otp: null,
    otpGenerationDate: null,
    recoveryToken: null,
    donorId: 164,
    employeeId: null,
    roleId: null,
    organizationId: null,
    createdOn: "2023-08-15T13:06:44.000Z",
    updatedOn: null,
    createdByUserId: null,
    updatedByUserId: null,
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MiwibmFtZSI6bnVsbCwiZW1haWwiOiJuZXd1c2VyMUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYiQxMiRoeGxQY2RxLkl1NEVFTDBJUEd0VW0uSnRvbkhIWEYxTW5ZNVhud2tBQUE3TlJ0QkY0ZmtXNiIsInBob25lIjoiKzE1MTY2MTg0NjIzIiwidXNlcl90eXBlIjoiRCIsImxvZ2luX3R5cGUiOiJtb2JpbGUiLCJpc19hY3RpdmUiOjEsIm90cCI6bnVsbCwib3RwX2dlbmVyYXRpb25fZGF0ZSI6bnVsbCwicmVjb3ZlcnlfdG9rZW4iOm51bGwsImRvbm9yX2lkIjoxNjQsImVtcGxveWVlX2lkIjpudWxsLCJyb2xlX2lkIjpudWxsLCJvcmdhbml6YXRpb25faWQiOm51bGwsImNyZWF0ZWRfb24iOiIyMDIzLTA4LTE1VDEzOjA2OjQ0LjAwMFoiLCJ1cGRhdGVkX29uIjpudWxsLCJjcmVhdGVkX2J5X3VzZXJfaWQiOm51bGwsInVwZGF0ZWRfYnlfdXNlcl9pZCI6bnVsbCwiaWF0IjoxNzA2MDkwOTUxLCJleHAiOjE3Mzc2MjY5NTF9.RL0aab0ux1sTdVjqUUoNIvU7RbBHpwazCUEBOiAaijk",
  );
  const String testEmail = 'newuser1@gmail.com';
  const String testPassword = 'Usman@123';
  const String message = 'Failed to connect to the network';

  test(
    'initial state',
    () {
      expect(signInBloc.state, SignInInitial());
    },
  );

  blocTest<SignInBloc, SignInState>(
    'emit [SigningIn, SignedIn] state when submit button pressed event triggers',
    build: () {
      when(mockSignInUsecase.execute(testEmail, testPassword))
          .thenAnswer((_) async => Right(testUser));
      return signInBloc;
    },
    act: (bloc) => bloc.add(
      const OnSubmitButtonPressed(email: testEmail, password: testPassword),
    ),
    expect: () => <SignInState>[SigningIn(), SignedIn(user: testUser)],
  );

  blocTest<SignInBloc, SignInState>(
    'emit [SigningIn, NotSignedIn] state when submit button pressed event triggers',
    build: () {
      when(mockSignInUsecase.execute(testEmail, testPassword)).thenAnswer(
        (_) async => const Left(ServerFailure(message)),
      );
      return signInBloc;
    },
    act: (bloc) => bloc.add(
      const OnSubmitButtonPressed(email: testEmail, password: testPassword),
    ),
    // expect: () => <SignInState>[SigningIn(), SignedIn(user: testUser)],
    expect: () {
      return <SignInState>[
        SigningIn(),
        const NotSignedIn(errorMessage: message),
      ];
    },
  );
}
