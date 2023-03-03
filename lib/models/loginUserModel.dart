// To parse this JSON data, do
//
//     final LoginUserModel = LoginUserModelFromJson(jsonString);

class LoginUserModel {
  LoginUserModel({
    required this.id,
    required this.section,
    required this.role,
    required this.stateId,
    required this.constituencyId,
    required this.panchayathId,
    required this.wardId,
    required this.unitId,
    required this.districtId,
    required this.username,
    required this.password,
    required this.status,
    required this.userType,
    required this.name,
    required this.address,
    required this.phone,
    required this.masterId,
    required this.memberId,
    required this.roleName,
    required this.memberType,
  });

  String id;
  String section;
  String? role;
  String stateId;
  String constituencyId;
  String panchayathId;
  String wardId;
  String unitId;
  String districtId;
  String username;
  String password;
  String status;
  String userType;
  String name;
  String address;
  String phone;
  String? masterId;
  String memberId;
  String roleName;
  String memberType;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
      id: json["id"],
      section: json["section"],
      role: json["role"],
      stateId: json["state_id"],
      constituencyId: json["constituency_id"],
      panchayathId: json["panchayath_id"],
      wardId: json["ward_id"],
      unitId: json["unit_id"],
      districtId: json["district_id"],
      username: json["username"],
      password: json["password"],
      status: json["status"],
      userType: json["user_type"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      masterId: json["master_id"],
      memberId: json["member_id"],
      roleName: json["role_name"],
      memberType: json["member_type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "section": section,
        "role": role,
        "state_id": stateId,
        "constituency_id": constituencyId,
        "panchayath_id": panchayathId,
        "ward_id": wardId,
        "unit_id": unitId,
        "district_id": districtId,
        "username": username,
        "password": password,
        "status": status,
        "user_type": userType,
        "name": name,
        "address": address,
        "phone": phone,
        "master_id": masterId,
        "member_id": memberId,
        "role_name": roleName,
        "member_type": memberType,
      };
}
