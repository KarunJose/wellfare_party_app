import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

createBearerAPI(dynamic data) async {
  String url = "$baseUrl/api/Masters/create_office_bearer";

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");

  var formData = FormData.fromMap({
    "user_id": userId,
    // "bearer_type": data['bearerTypeDropdownValue'],
    "office_bearer_id": data['id'],
    "state_id": data['stateDropDownValue'],
    "district_id": data['districtDropdownValue'],
    "constituency_id": data['constituencyDropdownValue'],
    "panchayath_id": data['panchayathDropdownValue'],
    "ward_id": data['wardDropdownValue'],
    "unit_id": data['unitDropdownValue'],
    "member_id": data['selectedMember'],
    "designation_id": data['designationDropDownValue'],
    "education_qualification": data['selectedEducationalQualification'],
    "job": data['selectedJob'],
    "other_job": data['otherJob'],
    "interested_area": data['selectedInterestedAreas'],
    "other_interested_area": data['otherInterestedArea'],
    "martial_arts": data['ayodhanakala'],
    "languages": data['selectedLanguages'],
    "other_language": data['otherLanguage'],
    "facebook": data['facebook'],
    "self_write": data['writer'],
    "instagram": data['instagram'],
    "instagram_active": data['igactive'],
    "twitter": data['twitter'],
    "twitter_active": data['twitteractive'],
    "speech": data['publicspeech'],
    "study_class": data['studyclass'],
    "write_poem_story": data['poemstory'],
    "slogan": data['slogan'],
    "service_attitude": data['service'],
    "councelling": data['counselling'],
    "personal_relationship": data['publicrelation'],
    "new_chances": data['opportunityfinder'],
    "organization": data['organize'],
    "team_work": data['teamwork'],
    "inspire_teammates": data['motivation'],
    "status": data['status'],
  });

  print({
    "user_id": userId,
    // "bearer_type": data['bearerTypeDropdownValue'],
    "office_bearer_id": data['id'],
    "state_id": data['stateDropDownValue'],
    "district_id": data['districtDropdownValue'],
    "constituency_id": data['constituencyDropdownValue'],
    "panchayath_id": data['panchayathDropdownValue'],
    "ward_id": data['wardDropdownValue'],
    "unit_id": data['unitDropdownValue'],
    "member_id": data['selectedMember'],
    "designation_id": data['designationDropDownValue'],
    "education_qualification": data['selectedEducationalQualification'],
    "job": data['selectedJob'],
    "other_job": data['otherJob'],
    "interested_area": data['selectedInterestedAreas'],
    "other_interested_area": data['otherInterestedArea'],
    "martial_arts": data['ayodhanakala'],
    "languages": data['selectedLanguages'],
    "other_language": data['otherLanguage'],
    "facebook": data['facebook'],
    "self_write": data['writer'],
    "instagram": data['instagram'],
    "instagram_active": data['igactive'],
    "twitter": data['twitter'],
    "twitter_active": data['twitteractive'],
    "speech": data['publicspeech'],
    "study_class": data['studyclass'],
    "write_poem_story": data['poemstory'],
    "slogan": data['slogan'],
    "service_attitude": data['service'],
    "councelling": data['counselling'],
    "personal_relationship": data['publicrelation'],
    "new_chances": data['opportunityfinder'],
    "organization": data['organize'],
    "team_work": data['teamwork'],
    "inspire_teammates": data['motivation'],
    "status": data['status'],
  });
  // for (var field in formData.fields) {
  //   print(field);
  // }

  var response = await Dio().post(url, data: formData);

  return response;
}

bearerListAPI({
  String? designation,
  /////
  String? stateId,
  String? districtId,
  String? constId,
  String? panchayathId,
  String? wardId,
  String? unitId,
  int? status,
}) async {
  String url = "$baseUrl/api/Masters/office_bearer_list";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "designation_id": designation,
    "state_id": stateId,
    "district_id": districtId,
    "constituency_id": constId,
    "panchayath_id": panchayathId,
    "ward_id": wardId,
    "unit_id": unitId,
    "status": status,
  });

  // for (var field in formData.fields) {
  //   print(field);
  // }

  var response = await Dio().post(url, data: formData);

  return response;
}
