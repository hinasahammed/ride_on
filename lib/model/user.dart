// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  User({
    this.userId,
    this.pswd,
    this.typeCode = "3",
  });

  String? userId;
  String? pswd;
  String typeCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UserId': userId,
      'Pswd': pswd,
      'TypeCode': typeCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['UserId'] != null ? map['UserId'] as String : null,
      pswd: map['Pswd'] != null ? map['Pswd'] as String : null,
      typeCode: map['TypeCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
