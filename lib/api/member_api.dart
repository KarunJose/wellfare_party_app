import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

// getMembersAPI({
//   String? gender,
//   String? stateId,
//   String? districtId,
//   String? constId,
//   String? panchayathId,
//   String? wardId,
//   String? unitId,
//   String? name,
//   String? phone,
//   String? status,
// }) async {
//   String url = "$baseUrl/api/Members/list";

//   final prefs = await SharedPreferences.getInstance();
//   var userId = prefs.getString("user_id");

//   var formData = FormData.fromMap({
//     "user_id": userId,
//     "member_type": "Member",
//     "gender": gender,
//   });
//   var response;
//   try {
//     response = await Dio().post(url, data: formData);
//   } catch (ex) {
//     print(ex);
//   }

//   return response;
// }

getMemberCountAPI() async {
  String url = "$baseUrl/api/Members/members_list_count";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

getMembersAPI({
  String? gender,
  /////
  required String? membertype,
  String? stateId,
  String? districtId,
  String? constId,
  String? panchayathId,
  String? wardId,
  String? unitId,
  String? name,
  String? phone,
  String? status,
}) async {
  String url = "$baseUrl/api/Members/list";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "member_type": membertype,
    "gender": gender,
    //
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "name": name,
    "phone": phone,
    "status": status,
  });
  print({
    "user_id": userId,
    "member_type": membertype,
    "gender": gender,
    //
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "name": name,
    "phone": phone,
    "status": status,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

createMemberAPI(
    {required String name,
    required String dob,
    required String gender,
    required String age,
    required String blood,
    required String mobile,
    required String email,
    // required String positions,
    required String address,
    required bool isAgree,
    String? adminssionYear,
    String? participationDate,
    required String stateId,
    required String districtId,
    required String constituencyId,
    required String panchayathId,
    required String wardId,
    required String unitId,
    required int status}
    // String ward,
    ) async {
  String url = "$baseUrl/api/Members/create_membership";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "status": status,
    "name": name,
    "address": address,
    "dob": dob,
    "gender": gender,
    "blood_group": blood,
    "mobile": mobile,
    "email": email,
    "age": int.parse(age),
    "admission_year": adminssionYear,
    "participation_date": participationDate,
    "is_agree": isAgree ? "Yes" : "No",
    // "positions": positions,
    "member_type": "primaryMember",
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
  });

  print({
    "user_id": userId,
    "status": status,
    "name": name,
    "address": address,
    "dob": dob,
    "gender": gender,
    "blood_group": blood,
    "mobile": mobile,
    "email": email,
    "age": int.parse(age),
    "admission_year": adminssionYear,
    "participation_date": participationDate,
    "is_agree": isAgree ? "Yes" : "No",
    // "positions": positions,
    "member_type": "primaryMember",
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

updateMemberAPI({
  required String id,
  required int status,
  required String name,
  required String dob,
  required String gender,
  required String age,
  required String blood,
  required String mobile,
  required String email,
  // required String positions,
  required String address,
  required bool isAgree,
  String? adminssionYear,
  String? participationDate,
  required String stateId,
  required String districtId,
  required String constituencyId,
  required String panchayathId,
  required String wardId,
  required String unitId,
}) async {
  String url = "$baseUrl/api/Members/update_membership";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "member_id": id,
    "status": status,
    "user_id": userId,
    "name": name,
    "address": address,
    "dob": dob,
    "gender": gender,
    "blood_group": blood,
    "mobile": mobile,
    "email": email,
    "age": int.parse(age),
    "admission_year": adminssionYear,
    "participation_date": participationDate,
    "is_agree": isAgree ? "Yes" : "No",
    // "positions": positions,
    "member_type": "primaryMember",
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}
