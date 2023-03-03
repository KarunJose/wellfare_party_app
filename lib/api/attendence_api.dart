import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

getAttendenceReportAPI({
  String? fromDate,
  String? toDate,
}) async {
  String url = "$baseUrl/api/Members/attendance_report_list";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var stateId = prefs.getString("state_id");
  var districtId = prefs.getString("district_id");
  var constId = prefs.getString("constituency_id");
  var panchayathId = prefs.getString("panchayath_id");

  var wardId = prefs.getString("ward_id");
  var unitId = prefs.getString("unit_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "from": fromDate,
    "to": toDate
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

addAttendenceAPI({
  String? meetingDate,
  List<String>? memberId,
  List<String>? status,
}) async {
  String url = "$baseUrl/api/Members/add_attendance";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "meeting_date": meetingDate,
    "member_id": memberId,
    "status": status
  });

  print({
    "user_id": userId,
    "meeting_date": meetingDate,
    "member_id": memberId,
    "status": status
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
