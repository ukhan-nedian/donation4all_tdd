import 'dart:convert';

import 'package:error/error.dart';
import 'package:http/http.dart' as http;
import 'package:search_donor/src/data/data_sources/search_donor_remote_data_source.dart';
import 'package:search_donor/src/domain/entities/ResponseEntity.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:urls/urls.dart';

class SearchDonorRemoteDataSourceImpl extends SearchDonorRemoteDataSource {
  final http.Client client;

  SearchDonorRemoteDataSourceImpl({required this.client});

  @override
  Future<UserDonor> searchDonor(String email) async {
    final http.Response response = await client.post(
      Uri.parse('${Urls.baseUrl}/user/getuserdonorbyemail'),
      body: jsonEncode(<String, dynamic>{'email': email, 'userType': 'D'}),
    );

    if (response.statusCode == 200) {
      var responseEntity = ResponseEntity.fromJson(jsonDecode(response.body));
      if (responseEntity.statusCode != 200 &&
          !(responseEntity.success ?? true)) {
        throw ApiException(
          errorMessage: responseEntity.message ?? 'User not found',
        );
      }
      return responseEntity.userDonor ?? UserDonor();
    } else {
      throw ServerException();
    }
  }
}
