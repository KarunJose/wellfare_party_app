import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';


getPanchayatAPI(
  
) async {
 String url = "$baseUrl/api/Masters/panchayath";
 final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var districtId = prefs.getString("district_id");

  var formData = FormData.fromMap(
    {
       "user_id": userId,
        "district_id": districtId,
    }
  );

   var response = await Dio().post(url, data: formData);

  return response;
 }