import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:temp_donor/src/data/repository/temp_donor_repository_impl.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTempDonorRemoteDataSource mockTempDonorRemoteDataSource;
  late TempDonorRepositoryImpl tempDonorRepositoryImpl;

  setUp(() {
    mockTempDonorRemoteDataSource = MockTempDonorRemoteDataSource();
    tempDonorRepositoryImpl = TempDonorRepositoryImpl(
      tempDonorRemoteDataSource: mockTempDonorRemoteDataSource,
    );
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

  test('Temp donor added when call to data source is successful', () async {
    // Arrange
    when(mockTempDonorRemoteDataSource.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    )).thenAnswer((_) async => testTempDonor);

    // Act
    final result = await tempDonorRepositoryImpl.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    );

    // Assert
    expect(result, equals(Right(testTempDonor)));
  });

  test('Add Temp donor failed when call to data source is unsuccessful',
      () async {
    // Arrange
    when(mockTempDonorRemoteDataSource.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    )).thenThrow(ServerException());

    // Act
    final result = await tempDonorRepositoryImpl.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    );

    // Assert
    expect(result, equals(Left(serverFailure)));
  });

  test(
      'Add Temp donor throws ConnectionFailure when the device has no internet',
      () async {
    // Arrange
    when(mockTempDonorRemoteDataSource.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    )).thenThrow(SocketException());

    // Act
    final result = await tempDonorRepositoryImpl.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    );

    // Assert
    expect(result, equals(const Left(ConnectionFailure('Failed to connect'))));
  });
}
