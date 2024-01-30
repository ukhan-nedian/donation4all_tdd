import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:temp_donor/src/presentation/bloc/temp_donor_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAddTempDonorUsecase mockAddTempDonorUsecase;
  late TempDonorBloc tempDonorBloc;

  setUp(() {
    mockAddTempDonorUsecase = MockAddTempDonorUsecase();
    tempDonorBloc = TempDonorBloc(addTempDonorUsecase: mockAddTempDonorUsecase);
  });

  const String testFirstName = 'usman';
  const String testLastName = 'khan';
  const String testEmail = 'usman.khan@evantagesoft.com';
  const String testPassword = 'Usman@123';
  const String testMobile = '+12462498393';
  final TempDonor testTempDonor = TempDonor(
    insertId: 84,
    message: "otp has been send to your registered email address",
  );
  ServerFailure serverFailure = const ServerFailure('An error has occurred');

  test('initial state', () {
    expect(tempDonorBloc.state, equals(TempDonorInitial()));
  });

  blocTest<TempDonorBloc, TempDonorState>(
    'emit [AddingTempDonor, TempDonorAdded] state when submit button was pressed',
    build: () {
      when(mockAddTempDonorUsecase.execute(
        testFirstName,
        testLastName,
        testEmail,
        testPassword,
        testMobile,
      )).thenAnswer((_) async => Right(testTempDonor));
      return tempDonorBloc;
    },
    act: (bloc) => bloc.add(
      const OnSubmitButtonPressed(
        firstName: testFirstName,
        lastName: testLastName,
        email: testEmail,
        password: testPassword,
        mobile: testMobile,
      ),
    ),
    expect: () => <TempDonorState>[
      AddingTempDonor(),
      TempDonorAdded(tempDonor: testTempDonor),
    ],
  );

  blocTest<TempDonorBloc, TempDonorState>(
    'emit [AddingTempDonor, TempDonorNotAdded] state when submit button was pressed',
    build: () {
      when(mockAddTempDonorUsecase.execute(
        testFirstName,
        testLastName,
        testEmail,
        testPassword,
        testMobile,
      )).thenAnswer((_) async => Left(serverFailure));
      return tempDonorBloc;
    },
    act: (bloc) => bloc.add(
      const OnSubmitButtonPressed(
        firstName: testFirstName,
        lastName: testLastName,
        email: testEmail,
        password: testPassword,
        mobile: testMobile,
      ),
    ),
    expect: () => <TempDonorState>[
      AddingTempDonor(),
      TempDonorNotAdded(errorMessage: serverFailure.message),
    ],
  );
}
