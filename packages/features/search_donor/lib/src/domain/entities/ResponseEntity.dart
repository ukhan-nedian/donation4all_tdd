import 'package:equatable/equatable.dart';

import 'UserDonor.dart';

/// statusCode : 200
/// success : true
/// data : {"userId":52,"name":null,"email":"newuser1@gmail.com","loginType":"mobile","phone":"+15166184623","userType":"D","isActive":1,"roleId":null,"organizationId":null,"donorId":164,"firstName":"New","lastName":"User1","address":"EVS"}
/// message : "User fetched successfully"

class ResponseEntity extends Equatable {
  ResponseEntity({
    this.statusCode,
    this.success,
    this.userDonor,
    this.message,
  });

  ResponseEntity.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    success = json['success'];
    userDonor = ((json['data'].runtimeType != List) && (json['data'] != null))
        ? UserDonor.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  int? statusCode;
  bool? success;
  UserDonor? userDonor;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['success'] = success;
    if (userDonor != null) {
      map['data'] = userDonor?.toJson();
    }
    map['message'] = message;
    return map;
  }

  @override
  List<Object?> get props => [statusCode, success, userDonor, message];
}
