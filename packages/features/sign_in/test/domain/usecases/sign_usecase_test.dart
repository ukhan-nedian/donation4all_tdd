import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:sign_in/src/domain/usecases/sign_in_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSignInRepository mockSignInRepository;
  late SignInUsecase signIn;

  setUp(
    () {
      mockSignInRepository = MockSignInRepository();
      signIn = SignInUsecase(mockSignInRepository);
    },
  );

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
    'sign in test',
    () async {
      // Arrange
      when(mockSignInRepository.signIn(testEmail, testPassword))
          .thenAnswer((_) async => Right(testUser));

      // Act
      final result = await signIn.execute(testEmail, testPassword);

      // Assert
      expect(result, Right(testUser));
    },
  );
}
