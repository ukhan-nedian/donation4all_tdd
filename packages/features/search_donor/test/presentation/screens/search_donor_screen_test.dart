import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_donor/search_donor.dart';

class MockSearchDonorBloc extends MockBloc<SearchDonorEvent, SearchDonorState>
    implements SearchDonorBloc {}

class FakeSearchDonorState extends Fake implements SearchDonorState {}

class FakeSearchDonorEvent extends Fake implements SearchDonorEvent {}

void main() {
  late MockSearchDonorBloc mockSearchDonorBloc;

  setUp(() {
    mockSearchDonorBloc = MockSearchDonorBloc();
    HttpOverrides.global = null;
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

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<SearchDonorBloc>(
        create: (context) => mockSearchDonorBloc,
        child: body,
      ),
    );
  }

  testWidgets('initial state', (widgetTester) async {
    // Arrange
    when(() => mockSearchDonorBloc.state).thenReturn(SearchDonorInitial());

    // Act
    await widgetTester.pumpWidget(
      makeTestableWidget(const SearchDonorScreen()),
    );
    await fillTextFieldAndTapButton(widgetTester, testEmail);

    // Assert
  });

  testWidgets(
    'show progress indicator when state is SearchingDonor',
    (widgetTester) async {
      // Arrange
      when(() => mockSearchDonorBloc.state).thenReturn(SearchingDonor());

      // Act
      await widgetTester.pumpWidget(
        makeTestableWidget(const SearchDonorScreen()),
      );
      var circularProgressIndicator = find.byType(CircularProgressIndicator);

      // Assert
      expect(circularProgressIndicator, findsOneWidget);
    },
  );

  testWidgets(
    'show user donor data when state is DonorFound',
    (widgetTester) async {
      // Arrange
      when(() => mockSearchDonorBloc.state)
          .thenReturn(DonorFound(userDonor: testUserDonor));

      // Act
      await widgetTester.pumpWidget(
        makeTestableWidget(const SearchDonorScreen()),
      );
      var userDonorTest = find.byKey(const Key('user_donor_text'));

      // Assert
      expect(userDonorTest, findsOneWidget);
    },
  );
}

Future<void> fillTextFieldAndTapButton(
  WidgetTester widgetTester,
  String testEmail,
) async {
  await fillEmailTextField(widgetTester, testEmail);
  await tapSubmitButton(widgetTester);
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

Future<void> tapSubmitButton(WidgetTester widgetTester) async {
  Finder submitButton = find.byType(AppButton);
  expect(submitButton, findsOneWidget);
  await widgetTester.tap(submitButton);
  await widgetTester.pump();
}
