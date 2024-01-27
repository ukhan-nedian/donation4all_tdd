import 'dart:convert';

import 'package:error/error.dart';
import 'package:http/http.dart' as http;
import 'package:temp_donor/src/domain/entities/ResponseEntity.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';
import 'package:urls/urls.dart';

abstract class TempDonorRemoteDataSource {
  Future<TempDonor> addTempDonor(
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
  );
}

class TempDonorRemoteDataSourceImpl extends TempDonorRemoteDataSource {
  final http.Client client;

  TempDonorRemoteDataSourceImpl({required this.client});

  @override
  Future<TempDonor> addTempDonor(
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
  ) async {
    var jsonBody = jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': mobile,
      'userType': 'D',
    });
    final http.Response response = await client.post(
      Uri.parse('${Urls.baseUrl}/tempdonor/add'),
      body: jsonBody,
      headers: Urls.headers,
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      ResponseEntity responseEntity = ResponseEntity.fromJson(responseBody);
      return responseEntity.tempDonor ?? TempDonor();
    } else {
      throw ServerException();
    }
  }
}
