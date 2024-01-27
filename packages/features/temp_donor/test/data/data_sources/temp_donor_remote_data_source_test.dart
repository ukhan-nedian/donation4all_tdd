import 'dart:convert';

import 'package:error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:json_reader/json_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:temp_donor/src/data/data_sources/temp_donor_remote_data_source.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:urls/urls.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TempDonorRemoteDataSourceImpl tempDonorRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    tempDonorRemoteDataSourceImpl =
        TempDonorRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String testFirstName = 'usman';
  const String testLastName = 'khan';
  const String testEmail = 'usman.khan@evantagesoft.com';
  const String testPassword = 'Usman@123';
  const String testMobile = '+12462498393';
  final String testJsonBody = jsonEncode(<String, String>{
    'firstName': testFirstName,
    'lastName': testLastName,
    'email': testEmail,
    'password': testPassword,
    'phone': testMobile,
    'userType': 'D',
  });

  test('temp donor success when the response code is 200', () async {
    // Arrange
    when(mockHttpClient.post(
      Uri.parse('${Urls.baseUrl}/tempdonor/add'),
      body: testJsonBody,
      headers: Urls.headers,
    )).thenAnswer((_) async => http.Response(
          readJson('helpers/dummy_data/dummy_temp_donor_response.json'),
          200,
        ));

    try {
      // Act
      final result = await tempDonorRemoteDataSourceImpl.addTempDonor(
        testFirstName,
        testLastName,
        testEmail,
        testPassword,
        testMobile,
      );
      // Assert
      expect(result, isA<TempDonor>());
    } catch (e) {
      // Assert
      expect(e, isA<ServerException>());
    }
  });
}
