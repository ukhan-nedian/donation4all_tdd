import 'dart:convert';

import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:json_reader/json_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in/src/data/data_sources/impl/sign_in_remote_data_source_impl.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:urls/urls.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late SignInRemoteDataSourceImpl signInRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    signInRemoteDataSourceImpl =
        SignInRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String testEmail = 'newuser1@gmail.com';
  const String testPassword = 'Usman@123';

  group(
    'sign in test',
    () {
      test(
        'sign in success when the response code is 200',
        () async {
          // Arrange
          when(
            mockHttpClient.post(
              Uri.parse('${Urls.baseUrl}/user/mobilesignin'),
              body: jsonEncode(
                <String, dynamic>{
                  'email': testEmail,
                  'password': testPassword,
                  'isActive': 1,
                  'userType': 'D',
                },
              ),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_sign_in_response.json'),
              200,
            ),
          );

          try {
            // Act
            final result = await signInRemoteDataSourceImpl.signIn(
              testEmail,
              testPassword,
            );

            // Assert
            expect(result, isA<User>());
          } catch (e) {
            // Assert
            expect(e, isA<ServerException>());
          }
        },
      );

      test(
        'sign in api throws ServerException when the response code is not 200',
        () async {
          // Arrange
          when(mockHttpClient.get(Uri.parse(Urls.baseUrl))).thenAnswer(
            (_) async => http.Response('Not found', 404),
          );

          try {
            // Act
            final result = await signInRemoteDataSourceImpl.signIn(
              testEmail,
              testPassword,
            );

            // Assert
            expect(result, isA<User>());
          } catch (e) {
            // Assert
            expect(e, isA<ServerException>());
          }
        },
      );
    },
  );
}
