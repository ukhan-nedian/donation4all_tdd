import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:search_donor/src/domain/usecases/search_donor_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchDonorRepository mockSearchDonorRepository;
  late SearchDonorUsecase searchDonorUsecase;

  setUp(() {
    mockSearchDonorRepository = MockSearchDonorRepository();
    searchDonorUsecase =
        SearchDonorUsecase(searchDonorRepository: mockSearchDonorRepository);
  });

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
  const String testEmail = 'newuser1@gmail.com';

  test('search donor usecase test', () async {
    // Arrange
    when(mockSearchDonorRepository.searchDonor(testEmail))
        .thenAnswer((_) async => Right(testUserDonor));

    // Act
    final result = await searchDonorUsecase.execute(testEmail);

    // Assert
    expect(result, Right(testUserDonor));
  });
}
