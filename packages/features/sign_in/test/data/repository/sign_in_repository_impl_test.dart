import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in/src/data/repository/sign_in_repository_impl.dart';
import 'package:sign_in/src/domain/entities/User.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSignInRemoteDataSource mockSignInRemoteDataSource;
  late SignInRepositoryImpl signInRepositoryImpl;

  setUp(() async {
    mockSignInRemoteDataSource = MockSignInRemoteDataSource();
    signInRepositoryImpl = SignInRepositoryImpl(mockSignInRemoteDataSource);
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

  test(
    'sign in success when a call to data source is successful',
    () async {
      // Arrange
      when(mockSignInRemoteDataSource.signIn(testEmail, testPassword))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await signInRepositoryImpl.signIn(testEmail, testPassword);

      // Assert
      expect(result, equals(Right(testUser)));
    },
  );

  test(
    'sign in throws ServerFailure when a call to data source is unsuccessful',
    () async {
      // Arrange
      when(mockSignInRemoteDataSource.signIn(testEmail, testPassword))
          .thenThrow(ServerException());

      try {
        // Act
        final result =
            await signInRepositoryImpl.signIn(testEmail, testPassword);

        // Assert
        expect(
          result,
          equals(const Left(ServerFailure('An error has occurred'))),
        );
        // expect(result, equals(Right(testUser)));
      } catch (e) {
        // Assert
        // expect(e, isA<ServerFailure>());
        expect(e, equals(const Left(ServerFailure('An error has occurred'))));
      }
    },
  );

  test(
    'sign in throws ConnectionFailure when the device has no internet',
    () async {
      // Arrange
      when(mockSignInRemoteDataSource.signIn(testEmail, testPassword))
          .thenThrow(SocketException());

      try {
        // Act
        final result =
            await signInRepositoryImpl.signIn(testEmail, testPassword);

        // Assert
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
        // expect(result, equals(Right(testUser)));
      } catch (e) {
        // Assert
        // expect(e, isA<ServerFailure>());
        expect(e, equals(const Left(ServerFailure('An error has occurred'))));
      }
    },
  );
}
