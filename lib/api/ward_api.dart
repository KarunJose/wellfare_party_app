import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

fetchWardAPI() async {
  // String url = "$baseUrl/api/Masters/unit_wards";
  String url = "$baseUrl/api/Masters/wards";

  final prefs = await SharedPreferences.getInstance();
  var unitId = prefs.getString("unit_id");

  var formData = FormData.fromMap({
    "unit_id": unitId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
