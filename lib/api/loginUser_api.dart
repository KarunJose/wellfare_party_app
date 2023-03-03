import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainConst/api_const.dart';

fetchLoginUserAPI() async {
  String url = "$baseUrl/api/Masters/users_list";

  final prefs = await SharedPreferences.getInstance();
  var unitId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": unitId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

createLoginUserAPI({
  role,
  stateId,
  districtId,
  constituencyId,
  panchayathId,
  wardId,
  memberId,
  username,
  unitId,
  password,
  status,
}) async {
  String url = "$baseUrl/api/Members/create_member_login";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "role": role,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "member_id": memberId,
    "username": username,
    "password": password,
    "status": status,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

updateLoginUserAPI({
  role,
  stateId,
  districtId,
  constituencyId,
  panchayathId,
  wardId,
  memberId,
  username,
  unitId,
  password,
  status,
  memberLoginId,
}) async {
  String url = "$baseUrl/api/Members/update_member_login";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "role": role,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "member_id": memberId,
    "username": username,
    "password": password,
    "status": status,
    "member_login_id": memberLoginId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
