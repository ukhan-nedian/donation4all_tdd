import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_reader/json_reader.dart';
import 'package:temp_donor/src/domain/entities/ResponseEntity.dart';
import 'package:temp_donor/src/domain/entities/TempDonor.dart';

void main() {
  final TempDonor testTempDonor = TempDonor(
    insertId: 84,
    message: "otp has been send to your registered email address",
  );

  test('valid TempDonor Entity From Json', () {
    // Arrange
    final jsonMap = jsonDecode(
      readJson('helpers/dummy_data/dummy_temp_donor_response.json'),
    );

    // Act
    final ResponseEntity responseEntity = ResponseEntity.fromJson(jsonMap);

    // Assert
    expect(responseEntity.tempDonor, equals(testTempDonor));
  });
}
