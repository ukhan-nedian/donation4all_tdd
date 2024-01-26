import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/domain/entities/User.dart';

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

class FakeSignInState extends Fake implements SignInState {}

class FakeSignInEvent extends Fake implements SignInEvent {}

void main() {
  late MockSignInBloc mockSignInBloc;

  setUp(() {
    mockSignInBloc = MockSignInBloc();
    HttpOverrides.global = null;
  });

  const String testEmail = 'newuser1@gmail.com';
  const String testPassword = 'Usman@123';
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

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<SignInBloc>(
        create: (context) => mockSignInBloc,
        child: body,
      ),
    );
  }

  testWidgets(
    'initial state',
    (widgetTester) async {
      // Arrange
      when(() => mockSignInBloc.state).thenReturn(SignInInitial());

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const SignInScreen()));
      await fillTextFieldsAndTapButton(widgetTester, testEmail, testPassword);

      // Assert
    },
  );

  testWidgets(
    'show progress indicator when state is SigningIn',
    (widgetTester) async {
      // Arrange
      when(() => mockSignInBloc.state).thenReturn(SigningIn());

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const SignInScreen()));
      // await fillTextFieldsAndTapButton(widgetTester, testEmail, testPassword);
      var circularProgressIndicator = find.byType(CircularProgressIndicator);

      // Assert
      expect(circularProgressIndicator, findsOneWidget);
    },
  );

  testWidgets(
    'show user data when state is SignedIn',
    (widgetTester) async {
      // Arrange
      when(() => mockSignInBloc.state).thenReturn(SignedIn(user: testUser));

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const SignInScreen()));
      // await fillTextFieldsAndTapButton(widgetTester, testEmail, testPassword);
      var userText = find.byKey(const Key('user_text'));

      // Assert
      expect(userText, findsOneWidget);
    },
  );
}

Future<void> fillTextFieldsAndTapButton(
  WidgetTester widgetTester,
  String testEmail,
  String testPassword,
) async {
  await fillEmailTextField(widgetTester, testEmail);
  await fillPasswordTextField(widgetTester, testPassword);
  await tapSignInButton(widgetTester);
}

Future<void> fillEmailTextField(
  WidgetTester widgetTester,
  String testEmail,
) async {
  Finder emailTextField = find.byType(DonationTextFormField);
  expect(emailTextField, findsOneWidget);
  await widgetTester.enterText(emailTextField, testEmail);
  await widgetTester.pump();
  expect(find.text(testEmail), findsOneWidget);
}

Future<void> fillPasswordTextField(
  WidgetTester widgetTester,
  String testPassword,
) async {
  Finder passwordTextField = find.byType(DonationPasswordTextField);
  expect(passwordTextField, findsOneWidget);
  await widgetTester.enterText(passwordTextField, testPassword);
  await widgetTester.pump();
  expect(find.text(testPassword), findsOneWidget);
}

Future<void> tapSignInButton(WidgetTester widgetTester) async {
  Finder signInButton = find.byType(AppButton);
  expect(signInButton, findsOneWidget);
  await widgetTester.tap(signInButton);
  await widgetTester.pump();
}
