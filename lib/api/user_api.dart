import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

signInAPI(String username, String password) async {
  String url = "$baseUrl/api/auth/login";

  // var data = {
  //   "username": username,
  //   "password": password,
  // };

  var formData = FormData.fromMap({
    "username": username,
    "password": password,
  });

  var response = await Dio().post(url, data: formData);
  return response;
}

updateProfileNameAPI(String updatedProfileName) async {
  String url = "$baseUrl/api/Account/update_profile";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "name": updatedProfileName,
  });
  var response = await Dio().post(url, data: formData);
  return response;
}
