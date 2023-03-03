import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.status,
    required this.id,
    required this.username,
    required this.section,
    required this.role,
    required this.roleName,
    required this.unitId,
    required this.loggedIn,
  });

  bool status;
  String id;
  String username;
  String section;
  String role;
  String roleName;
  String unitId;
  bool loggedIn;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        id: json["id"],
        username: json["username"],
        section: json["section"],
        role: json["role"],
        roleName: json["role_name"],
        unitId: json["unit_id"],
        loggedIn: json["logged_in"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "username": username,
        "section": section,
        "role": role,
        "role_name": roleName,
        "unit_id": unitId,
        "logged_in": loggedIn,
      };
}
