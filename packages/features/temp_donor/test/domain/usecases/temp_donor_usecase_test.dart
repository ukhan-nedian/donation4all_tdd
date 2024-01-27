import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:temp_donor/src/domain/usecases/add_temp_donor_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTempDonorRepository mockTempDonorRepository;
  late AddTempDonorUsecase addTempDonorUsecase;

  setUp(() {
    mockTempDonorRepository = MockTempDonorRepository();
    addTempDonorUsecase =
        AddTempDonorUsecase(tempDonorRepository: mockTempDonorRepository);
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

  test('add temp donor usecase right test', () async {
    // Arrange
    when(mockTempDonorRepository.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    )).thenAnswer((_) async => Right(testTempDonor));

    // Act
    final result = await addTempDonorUsecase.execute(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    );

    // Assert
    expect(result, equals(Right(testTempDonor)));
  });

  test('add temp donor usecase failure test', () async {
    // Arrange
    when(mockTempDonorRepository.addTempDonor(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    )).thenAnswer((_) async => Left(serverFailure));

    // Act
    final result = await addTempDonorUsecase.execute(
      testFirstName,
      testLastName,
      testEmail,
      testPassword,
      testMobile,
    );

    // Assert
    expect(result, equals(Left(serverFailure)));
  });
}
