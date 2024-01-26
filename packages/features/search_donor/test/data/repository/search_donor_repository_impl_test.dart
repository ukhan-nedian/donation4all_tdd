import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_donor/src/data/repository/search_donor_repository_impl.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchDonorRemoteDataSource mockSearchDonorRemoteDataSource;
  late SearchDonorRepositoryImpl searchDonorRepositoryImpl;

  setUp(() {
    mockSearchDonorRemoteDataSource = MockSearchDonorRemoteDataSource();
    searchDonorRepositoryImpl = SearchDonorRepositoryImpl(
      searchDonorRemoteDataSource: mockSearchDonorRemoteDataSource,
    );
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

  test('search donor found when a call to data source is success', () async {
    // Arrange
    when(mockSearchDonorRemoteDataSource.searchDonor(testEmail))
        .thenAnswer((_) async => testUserDonor);

    // Act
    final result = await searchDonorRepositoryImpl.searchDonor(testEmail);

    // Assert
    expect(result, equals(Right(testUserDonor)));
  });

  test(
    'search donor throws server failure when a call to data source is unsuccessful',
    () async {
      // Arrange
      when(mockSearchDonorRemoteDataSource.searchDonor(testEmail))
          .thenThrow(ServerException());

      // Act
      final result = await searchDonorRepositoryImpl.searchDonor(testEmail);

      // Assert
      expect(
        result,
        equals(const Left(ServerFailure('An error has occurred'))),
      );
    },
  );

  test(
    'search donor throws connection failure when the device has no internet',
    () async {
      // Arrange
      when(mockSearchDonorRemoteDataSource.searchDonor(testEmail))
          .thenThrow(SocketException());

      // Act
      final result = await searchDonorRepositoryImpl.searchDonor(testEmail);

      // Assert
      expect(
        result,
        equals(
          const Left(ConnectionFailure('Failed to connect to the network')),
        ),
      );
    },
  );
}
