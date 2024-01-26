import 'package:equatable/equatable.dart';

/// userId : 52
/// name : null
/// email : "newuser1@gmail.com"
/// loginType : "mobile"
/// phone : "+15166184623"
/// userType : "D"
/// isActive : 1
/// roleId : null
/// organizationId : null
/// donorId : 164
/// firstName : "New"
/// lastName : "User1"
/// address : "EVS"

class UserDonor extends Equatable {
  UserDonor({
    this.userId,
    this.name,
    this.email,
    this.loginType,
    this.phone,
    this.userType,
    this.isActive,
    this.roleId,
    this.organizationId,
    this.donorId,
    this.firstName,
    this.lastName,
    this.address,
  });

  UserDonor.fromJson(dynamic json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    loginType = json['loginType'];
    phone = json['phone'];
    userType = json['userType'];
    isActive = json['isActive'];
    roleId = json['roleId'];
    organizationId = json['organizationId'];
    donorId = json['donorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
  }

  int? userId;
  String? name;
  String? email;
  String? loginType;
  String? phone;
  String? userType;
  int? isActive;
  dynamic roleId;
  dynamic organizationId;
  int? donorId;
  String? firstName;
  String? lastName;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['loginType'] = loginType;
    map['phone'] = phone;
    map['userType'] = userType;
    map['isActive'] = isActive;
    map['roleId'] = roleId;
    map['organizationId'] = organizationId;
    map['donorId'] = donorId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['address'] = address;
    return map;
  }

  @override
  List<Object?> get props => [
        userId,
        userType,
        name,
        email,
        loginType,
        phone,
        userType,
        isActive,
        roleId,
        organizationId,
        donorId,
        firstName,
        lastName,
        address,
      ];
}
