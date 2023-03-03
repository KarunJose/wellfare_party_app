import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

hierarchyInfoAPI() async {
  String url = "$baseUrl/api/Dashboard/master_counts";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
