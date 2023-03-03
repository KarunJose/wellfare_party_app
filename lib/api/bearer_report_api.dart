import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

fetchDesignationAPI() async {
  String url = "$baseUrl/api/Masters/designations";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });

  var response = await Dio().post(url, data: formData);

  return response;
}

fetchStateAPI() async {
  String url = "$baseUrl/api/Masters/states";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
  });

  var response = await Dio().post(url, data: formData);
  return response;
}

fetchDistrictAPi(String? stateId) async {
  String url = "$baseUrl/api/Masters/districts";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var data = {
    "user_id": userId,
  };

  if (stateId != null) {
    data["state_id"] = stateId;
  }

  var formData = FormData.fromMap(data);

  var response = await Dio().post(url, data: formData);
  return response;
}

fetchConstituencyAPI(String? districtId) async {
  String url = "$baseUrl/api/Masters/constituencies";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var data = {
    "user_id": userId,
  };

  if (districtId != null) {
    data["district_id"] = districtId;
  }

  var formData = FormData.fromMap(data);

  print(data);

  var response = await Dio().post(url, data: formData);
  return response;
}

fetchPanchayathAPI(String? constituencyId) async {
  String url = "$baseUrl/api/Masters/panchayath";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var data = {
    "user_id": userId,
  };

  if (constituencyId != null) {
    data["constituency_id"] = constituencyId;
  }

  var formData = FormData.fromMap(data);
  var response = await Dio().post(url, data: formData);
  return response;
}

fetchWardAPI(String? panchayathId) async {
  String url = "$baseUrl/api/Masters/wards";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var data = {
    "user_id": userId,
  };

  if (panchayathId != null) {
    data["panchayath_id"] = panchayathId;
  }

  var formData = FormData.fromMap(data);
  var response = await Dio().post(url, data: formData);
  return response;
}

fetchUnitAPI(String? wardId) async {
  String url = "$baseUrl/api/Masters/units";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var data = {
    "user_id": userId,
  };

  if (wardId != null) {
    data["panchayath_id"] = wardId;
  }

  var formData = FormData.fromMap(data);
  var response = await Dio().post(url, data: formData);
  return response;
}

fetchSubcommitteeAPI() async {
  String url = "$baseUrl/api/Masters/subcommittee";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);
  return response;
}

fetchBearerReportResultAPI(
    String stateId,
    String districtId,
    String constituencyId,
    String panchayathId,
    String wardId,
    String unitId,
    String designationId) async {
  String url = "$baseUrl/api/Reports/office_bearer_search";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "designation_id": designationId,
  });
  var response = await Dio().post(url, data: formData);
  return response;
}

fetchBearerSubcommitteeResultAPI(
  String stateId,
  String districtId,
  String constituencyId,
  String panchayathId,
  String wardId,
  String unitId,
  String designationId,
  String subcommitteeId,
) async {
  String url = "$baseUrl/api/Reports/office_bearer_subcommittee_search";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constituencyId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "designation_id": designationId,
    "subcommittee_id": subcommitteeId,
  });
  var response = await Dio().post(url, data: formData);
  return response;
}
