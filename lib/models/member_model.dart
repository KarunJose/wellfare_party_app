// To parse this JSON data, do
//
//     final member = memberFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  Member({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.constituencyId,
    required this.panchayathId,
    required this.wardId,
    required this.unitId,
    required this.memberType,
    required this.name,
    required this.address,
    required this.dob,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    required this.mobile,
    required this.email,
    this.admissionYear,
    this.participationDate,
    required this.isAgree,
    // required this.positions,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    required this.regNo,
  });

  String id;
  String stateId;
  String districtId;
  String constituencyId;
  String panchayathId;
  String? wardId;
  String unitId;
  dynamic memberType;
  String name;
  String address;
  DateTime dob;
  String age;
  String gender;
  String? bloodGroup;
  String mobile;
  String email;
  String? admissionYear;
  DateTime? participationDate;
  String isAgree;
  // String positions;
  String status;
  String createdAt;
  String createdBy;
  String? regNo;

  factory Member.fromJson(Map<String, dynamic> json) {
    Member member = Member(
      id: json["id"],
      stateId: json["state_id"],
      districtId: json["district_id"],
      constituencyId: json["constituency_id"],
      panchayathId: json["panchayath_id"],
      wardId: json["ward_id"],
      unitId: json["unit_id"],
      memberType: json["member_type"],
      name: json["name"],
      address: json["address"],
      dob: DateTime.parse(json["dob"]),
      age: json["age"],
      gender: json["gender"],
      bloodGroup: json["blood_group"],
      mobile: json["mobile"],
      email: json["email"],
      admissionYear: json["admission_year"],
      isAgree: json["is_agree"],
      // positions: json["positions"],
      status: json["status"],
      regNo: json["reg_no"],
      createdAt: json["created_at"],
      createdBy: json["created_by"],
    );

    if (json["participation_date"] != null &&
        json["participation_date"] != "0000-00-00") {
      member.participationDate = DateTime.parse(json["participation_date"]);
    }

    return member;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "district_id": districtId,
        "constituency_id": constituencyId,
        "panchayath_id": panchayathId,
        "ward_id": wardId,
        "unit_id": unitId,
        "member_type": memberType,
        "name": name,
        "address": address,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "blood_group": bloodGroup,
        "mobile": mobile,
        "email": email,
        "admission_year": admissionYear,
        "participation_date":
            "${participationDate!.year.toString().padLeft(4, '0')}-${participationDate!.month.toString().padLeft(2, '0')}-${participationDate!.day.toString().padLeft(2, '0')}",
        "is_agree": isAgree,
        "positions": null,
        "status": status,
        "created_at": createdAt,
        "created_by": createdBy,
      };
}
