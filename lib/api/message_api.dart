import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

sendMessageAPI({
  String? recipientId,
  String? subject,
  String? message,
  String? stateId,
  String? districtId,
  String? constituencyId,
  String? panchayathId,
  String? unitId,
  String? attachmentName,
  String? attachmentData,
}) async {
  String url = "$baseUrl/api/Masters/send_message";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "recipient_id": recipientId,
    "subject": subject,
    "message": message,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "unit_id": unitId,
    "attachment_name": attachmentName,
    "attachment_data": attachmentData,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

getMessageAPI({
  String? title,
  String? message,
  String? attachment,
  String? date,
}) async {
  String url = "$baseUrl/api/Masters/message_list";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

deleteMessageAPI({
  String? messageId,
}) async {
  String url = "$baseUrl/api/Masters/delete_message";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({"user_id": userId, "message_id": messageId});
  var response = await Dio().post(url, data: formData);

  return response;
}
