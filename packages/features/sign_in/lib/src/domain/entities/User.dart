import 'package:equatable/equatable.dart';

/// userId : 52
/// name : null
/// email : "newuser1@gmail.com"
/// password : "$2b$12$hxlPcdq.Iu4EEL0IPGtUm.JtonHHXF1MnY5XnwkAAA7NRtBF4fkW6"
/// phone : "+15166184623"
/// userType : "D"
/// loginType : "mobile"
/// isActive : 1
/// otp : null
/// otpGenerationDate : null
/// recoveryToken : null
/// donorId : 164
/// employeeId : null
/// roleId : null
/// organizationId : null
/// createdOn : "2023-08-15T13:06:44.000Z"
/// updatedOn : null
/// createdByUserId : null
/// updatedByUserId : null
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MiwibmFtZSI6bnVsbCwiZW1haWwiOiJuZXd1c2VyMUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYiQxMiRoeGxQY2RxLkl1NEVFTDBJUEd0VW0uSnRvbkhIWEYxTW5ZNVhud2tBQUE3TlJ0QkY0ZmtXNiIsInBob25lIjoiKzE1MTY2MTg0NjIzIiwidXNlcl90eXBlIjoiRCIsImxvZ2luX3R5cGUiOiJtb2JpbGUiLCJpc19hY3RpdmUiOjEsIm90cCI6bnVsbCwib3RwX2dlbmVyYXRpb25fZGF0ZSI6bnVsbCwicmVjb3ZlcnlfdG9rZW4iOm51bGwsImRvbm9yX2lkIjoxNjQsImVtcGxveWVlX2lkIjpudWxsLCJyb2xlX2lkIjpudWxsLCJvcmdhbml6YXRpb25faWQiOm51bGwsImNyZWF0ZWRfb24iOiIyMDIzLTA4LTE1VDEzOjA2OjQ0LjAwMFoiLCJ1cGRhdGVkX29uIjpudWxsLCJjcmVhdGVkX2J5X3VzZXJfaWQiOm51bGwsInVwZGF0ZWRfYnlfdXNlcl9pZCI6bnVsbCwiaWF0IjoxNzA2MDkwOTUxLCJleHAiOjE3Mzc2MjY5NTF9.RL0aab0ux1sTdVjqUUoNIvU7RbBHpwazCUEBOiAaijk"

class User extends Equatable {
  User({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.userType,
    this.loginType,
    this.isActive,
    this.otp,
    this.otpGenerationDate,
    this.recoveryToken,
    this.donorId,
    this.employeeId,
    this.roleId,
    this.organizationId,
    this.createdOn,
    this.updatedOn,
    this.createdByUserId,
    this.updatedByUserId,
    this.token,
  });

  User.fromJson(dynamic json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    userType = json['userType'];
    loginType = json['loginType'];
    isActive = json['isActive'];
    otp = json['otp'];
    otpGenerationDate = json['otpGenerationDate'];
    recoveryToken = json['recoveryToken'];
    donorId = json['donorId'];
    employeeId = json['employeeId'];
    roleId = json['roleId'];
    organizationId = json['organizationId'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdByUserId = json['createdByUserId'];
    updatedByUserId = json['updatedByUserId'];
    token = json['token'];
  }

  int? userId;
  dynamic name;
  String? email;
  String? password;
  String? phone;
  String? userType;
  String? loginType;
  int? isActive;
  dynamic otp;
  dynamic otpGenerationDate;
  dynamic recoveryToken;
  int? donorId;
  dynamic employeeId;
  dynamic roleId;
  dynamic organizationId;
  String? createdOn;
  dynamic updatedOn;
  dynamic createdByUserId;
  dynamic updatedByUserId;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['userType'] = userType;
    map['loginType'] = loginType;
    map['isActive'] = isActive;
    map['otp'] = otp;
    map['otpGenerationDate'] = otpGenerationDate;
    map['recoveryToken'] = recoveryToken;
    map['donorId'] = donorId;
    map['employeeId'] = employeeId;
    map['roleId'] = roleId;
    map['organizationId'] = organizationId;
    map['createdOn'] = createdOn;
    map['updatedOn'] = updatedOn;
    map['createdByUserId'] = createdByUserId;
    map['updatedByUserId'] = updatedByUserId;
    map['token'] = token;
    return map;
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        password,
        phone,
        userType,
        loginType,
        isActive,
        otp,
        otpGenerationDate,
        recoveryToken,
        donorId,
        employeeId,
        roleId,
        organizationId,
        createdOn,
        updatedOn,
        createdByUserId,
        updatedByUserId,
        token,
      ];
}
