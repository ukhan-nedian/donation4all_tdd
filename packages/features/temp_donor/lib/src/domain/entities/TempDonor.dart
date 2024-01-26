import 'package:equatable/equatable.dart';

/// insertId : 84
/// message : "otp has been send to your registered email address"

class TempDonor extends Equatable {
  TempDonor({this.insertId, this.message});

  TempDonor.fromJson(dynamic json) {
    insertId = json['insertId'];
    message = json['message'];
  }

  int? insertId;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['insertId'] = insertId;
    map['message'] = message;
    return map;
  }

  @override
  List<Object?> get props => [insertId];
}
