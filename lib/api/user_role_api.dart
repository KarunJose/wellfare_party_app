import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

fetchUserRoleApi() async {
  String url = "$baseUrl/api/Masters/roles";

  final prefs = await SharedPreferences.getInstance();
  var unitId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": unitId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
