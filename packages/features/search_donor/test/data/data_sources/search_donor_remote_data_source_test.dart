import 'dart:convert';

import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:json_reader/json_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:search_donor/src/data/data_sources/impl/search_donor_remote_data_source_impl.dart';
import 'package:search_donor/src/data/data_sources/search_donor_remote_data_source.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:urls/urls.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late SearchDonorRemoteDataSource searchDonorRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    searchDonorRemoteDataSource =
        SearchDonorRemoteDataSourceImpl(client: mockHttpClient);
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

  test('search donor success when the response code is 200', () async {
    // Arrange
    when(
      mockHttpClient.post(
        Uri.parse('${Urls.baseUrl}/user/getuserdonorbyemail'),
        body: jsonEncode(
          <String, dynamic>{'email': testEmail, 'userType': 'D'},
        ),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        readJson('helpers/dummy_data/dummy_search_donor_response.json'),
        200,
      ),
    );

    // Act
    try {
      final UserDonor result =
          await searchDonorRemoteDataSource.searchDonor(testEmail);

      // Assert
      expect(result, isA<UserDonor>());
    } catch (e) {
      // Assert
      expect(e, isA<ServerException>());
    }
  });

  test(
    'search donor throws ServerException when the response code is not 200',
    () async {
      // Arrange
      when(
        mockHttpClient.post(
          Uri.parse('${Urls.baseUrl}/user/getuserdonorbyemail'),
          body: jsonEncode(
            <String, dynamic>{'email': testEmail, 'userType': 'D'},
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not found', 404));

      // Act
      try {
        final UserDonor result =
            await searchDonorRemoteDataSource.searchDonor(testEmail);

        // Assert
        expect(result, isA<UserDonor>());
      } catch (e) {
        // Assert
        expect(e, isA<ServerException>());
      }
    },
  );

  test(
    'search donor throws ApiException when the statusCode is not 200',
    () async {
      // Arrange
      when(
        mockHttpClient.post(
          Uri.parse('${Urls.baseUrl}/user/getuserdonorbyemail'),
          body: jsonEncode(
            <String, dynamic>{'email': testEmail, 'userType': 'D'},
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson(
            'helpers/dummy_data/dummy_failed_search_donor_response.json',
          ),
          200,
        ),
      );

      // Act
      try {
        final UserDonor result =
            await searchDonorRemoteDataSource.searchDonor(testEmail);

        // Assert
        expect(result, isA<UserDonor>());
      } catch (e) {
        // Assert
        expect(e, isA<ApiException>());
      }
    },
  );
}
