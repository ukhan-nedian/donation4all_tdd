import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:search_donor/src/presentation/bloc/search_donor_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchDonorUsecase mockSearchDonorUsecase;
  late SearchDonorBloc searchDonorBloc;

  setUp(() {
    mockSearchDonorUsecase = MockSearchDonorUsecase();
    searchDonorBloc =
        SearchDonorBloc(searchDonorUsecase: mockSearchDonorUsecase);
  });

  const String testEmail = 'newuser1@gmail.com';
  final UserDonor testUserDonor = UserDonor(
    userId: 52,
    name: null,
    email: "newuser1@gmail.com",
    loginType: "mobile",
    phone: "+15166184623",
    userType: "D",
    isActive: 1,
    roleId: null,
    organizationId: null,
    donorId: 164,
    firstName: "New",
    lastName: "User1",
    address: "EVS",
  );
  String message = 'Failed to connect to the network';

  test('initial state', () {
    expect(searchDonorBloc.state, SearchDonorInitial());
  });

  blocTest<SearchDonorBloc, SearchDonorState>(
    'emit [SearchingDonor, DonorFound] state when submit button pressed event occurs',
    build: () {
      when(mockSearchDonorUsecase.execute(testEmail))
          .thenAnswer((_) async => Right(testUserDonor));
      return searchDonorBloc;
    },
    act: (bloc) => bloc.add(const OnSubmitButtonPressed(email: testEmail)),
    expect: () => <SearchDonorState>[
      SearchingDonor(),
      DonorFound(userDonor: testUserDonor),
    ],
  );

  blocTest<SearchDonorBloc, SearchDonorState>(
    'emit [SearchingDonor, DonorNotFound] state when submit button pressed event occurs',
    build: () {
      when(mockSearchDonorUsecase.execute(testEmail))
          .thenAnswer((_) async => Left(ServerFailure(message)));
      return searchDonorBloc;
    },
    act: (bloc) => bloc.add(const OnSubmitButtonPressed(email: testEmail)),
    expect: () => <SearchDonorState>[
      SearchingDonor(),
      DonorNotFound(errorMessage: message),
    ],
  );
}
