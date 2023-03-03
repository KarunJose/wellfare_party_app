import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

getNotificationAPI() async {
  String url = "$baseUrl/api/Notifications/list";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

getInboxNotificationAPI() async {
  String url = "$baseUrl/api/Notifications/inbox_list";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

readNotificationAPI(String id) async {
  String url = "$baseUrl/api/Notifications/read_notification";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "notification_id": id,
  });
  var response = await Dio().post(url, data: formData);
  return response;
}
