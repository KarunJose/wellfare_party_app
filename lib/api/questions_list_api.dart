import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';

listQuestionAPI() async {
  String url = "$baseUrl/index.php/api/Report/list_questions";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

saveAnswersAPI({
  String? reportId,
  String? mainQanswer,
  String? subQanswer,
  int? status,
}) async {
  String url = "$baseUrl/index.php/api/Report/save_report_answers";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "report_id": reportId,
    "main_ques_answers": mainQanswer,
    "sub_ques_answers": subQanswer,
    "status": status,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

updateAnswersAPI({
  String? reportId,
  String? mainQanswer,
  String? subQanswer,
  String? editedMainQanswer,
  String? editedSubQanswer,
  int? status,
}) async {
  String url = "$baseUrl/index.php/api/Report/update_report_answers";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "report_id": reportId,
    "main_ques_answers": mainQanswer,
    "sub_ques_answers": subQanswer,
    "edited_main_ques_answers": editedMainQanswer,
    "edited_sub_ques_answers": editedSubQanswer,
    "status": status,
  });
  print({
    "user_id": userId,
    "report_id": reportId,
    "main_ques_answers": mainQanswer,
    "sub_ques_answers": subQanswer,
    "edited_main_ques_answers": editedMainQanswer,
    "edited_sub_ques_answers": editedSubQanswer,
    "status": status,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

submittedQuestionsListAPI() async {
  String url = "$baseUrl/index.php/api/Report/report_submit_details";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

draftAPI() async {
  String url = "$baseUrl/index.php/api/Report/report_draft_details";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}

deleteAPI(String id) async {
  String url = "$baseUrl/index.php/api/Report/delete_submitted_answers";
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("user_id");
  var formData = FormData.fromMap({
    "user_id": userId,
    "report_id": id,
  });
  var response = await Dio().post(url, data: formData);

  return response;
}
