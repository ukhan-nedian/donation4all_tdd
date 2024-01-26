import 'dart:convert';

import 'package:error/error.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in/src/data/data_sources/sign_in_remote_data_source.dart';
import 'package:sign_in/src/domain/entities/ResponseEntity.dart';
import 'package:sign_in/src/domain/entities/User.dart';
import 'package:urls/urls.dart';

class SignInRemoteDataSourceImpl extends SignInRemoteDataSource {
  final http.Client client;

  SignInRemoteDataSourceImpl({required this.client});

  @override
  Future<User> signIn(String email, String password) async {
    final http.Response response = await client.post(
      Uri.parse('${Urls.baseUrl}/user/mobilesignin'),
      body: jsonEncode(
        <String, dynamic>{
          'email': email,
          'password': password,
          'isActive': 1,
          'userType': 'D',
        },
      ),
    );

    if (response.statusCode == 200) {
      var responseEntity = ResponseEntity.fromJson(jsonDecode(response.body));
      return responseEntity.user ?? User();
    } else {
      throw ServerException();
    }
  }
}
