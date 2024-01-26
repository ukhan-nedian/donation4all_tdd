import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_reader/json_reader.dart';
import 'package:search_donor/src/domain/entities/ResponseEntity.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';

void main() {
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
  test(
    'valid UserDonor Entity from Json',
    () {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_search_donor_response.json'),
      );

      // Act
      final ResponseEntity responseEntity = ResponseEntity.fromJson(jsonMap);

      // Assert
      expect(responseEntity.userDonor, equals(testUserDonor));
    },
  );
}
