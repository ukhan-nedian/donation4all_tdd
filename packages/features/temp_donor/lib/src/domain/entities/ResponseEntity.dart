import 'package:equatable/equatable.dart';

import 'TempDonor.dart';

/// statusCode : 200
/// success : true
/// tempDonor : {"insertId":84,"message":"otp has been send to your registered email address"}
/// message : "Temp Donor added successfully"

class ResponseEntity extends Equatable {
  ResponseEntity({
    this.statusCode,
    this.success,
    this.tempDonor,
    this.message,
  });

  ResponseEntity.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    success = json['success'];
    tempDonor = json['data'] != null ? TempDonor.fromJson(json['data']) : null;
    message = json['message'];
  }

  int? statusCode;
  bool? success;
  TempDonor? tempDonor;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['success'] = success;
    if (tempDonor != null) {
      map['data'] = tempDonor?.toJson();
    }
    map['message'] = message;
    return map;
  }

  @override
  List<Object?> get props => [statusCode, success, tempDonor, message];
}
