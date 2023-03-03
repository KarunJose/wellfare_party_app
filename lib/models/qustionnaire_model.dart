// To parse this JSON data, do
//
//     final questionnaireModel = questionnaireModelFromJson(jsonString);

import 'dart:convert';

QuestionnaireModel questionnaireModelFromJson(String str) =>
    QuestionnaireModel.fromJson(json.decode(str));

String questionnaireModelToJson(QuestionnaireModel data) =>
    json.encode(data.toJson());

class QuestionnaireModel {
  QuestionnaireModel({
    required this.id,
    required this.reportType,
    required this.reportTitle,
    required this.reportSubTitle,
    required this.description,
    required this.reportFor,
    required this.reportFrom,
    required this.reportTo,
    required this.reportActive,
    required this.departmentId,
    required this.createdBy,
    required this.createdAt,
    required this.mainQuestions,
    required this.departmentName,
    required this.submittedMonth,
    required this.submittedOn,
    required this.dipCode,
  });

  String id;
  String reportType;
  String reportTitle;
  String reportSubTitle;
  String description;
  String reportFor;
  DateTime reportFrom;
  DateTime reportTo;
  String reportActive;
  String departmentId;
  String createdBy;
  String createdAt;
  String departmentName;
  String? dipCode;
  List<Question> mainQuestions;
  String? submittedMonth;
  String? submittedOn;

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) =>
      QuestionnaireModel(
        id: json["id"],
        reportType: json["report_type"],
        reportTitle: json["report_title"],
        reportSubTitle: json["report_sub_title"],
        description: json["description"],
        reportFor: json["report_for"],
        reportFrom: DateTime.parse(json["report_from"]),
        reportTo: DateTime.parse(json["report_to"]),
        reportActive: json["report_active"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        submittedMonth: json["submitted_month"],
        submittedOn: json["submitted_on"],
        dipCode: json["department_code"],
        mainQuestions: List<Question>.from(
            json["main_questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_type": reportType,
        "report_title": reportTitle,
        "report_sub_title": reportSubTitle,
        "description": description,
        "report_for": reportFor,
        "report_from":
            "${reportFrom.year.toString().padLeft(4, '0')}-${reportFrom.month.toString().padLeft(2, '0')}-${reportFrom.day.toString().padLeft(2, '0')}",
        "report_to":
            "${reportTo.year.toString().padLeft(4, '0')}-${reportTo.month.toString().padLeft(2, '0')}-${reportTo.day.toString().padLeft(2, '0')}",
        "report_active": reportActive,
        "department_id": departmentId,
        "department_name": departmentName,
        "created_by": createdBy,
        "created_at": createdAt,
        "submitted_month": submittedMonth,
        "submitted_on": submittedOn,
        "department_code": dipCode,
        "main_questions":
            List<dynamic>.from(mainQuestions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.id,
    required this.reportId,
    required this.questionNumber,
    required this.question,
    required this.questionType,
    required this.questionTypeName,
    required this.answer,
    required this.male,
    required this.female,
    required this.total,
    required this.subQuestions,
    required this.mainQuestionId,
  });

  String id;
  String? reportId;
  String questionNumber;
  String question;
  String questionType;
  String questionTypeName;
  String? answer;
  String? male;
  String? female;
  String? total;
  List<Question>? subQuestions;
  String? mainQuestionId;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        reportId: json["report_id"],
        questionNumber: json["question_number"],
        question: json["question"],
        questionType: json["question_type"],
        questionTypeName: json["question_type_name"],
        answer: json["answer"],
        male: json["male"],
        female: json["female"],
        total: json["total"],
        subQuestions: json["sub_questions"] == null
            ? null
            : List<Question>.from(
                json["sub_questions"].map((x) => Question.fromJson(x))),
        mainQuestionId: json["main_question_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "question_number": questionNumber,
        "question": question,
        "question_type": questionType,
        "question_type_name": questionTypeName,
        "answer": answer,
        "male": male,
        "female": female,
        "total": total,
        "sub_questions": subQuestions == null
            ? null
            : List<dynamic>.from(subQuestions!.map((x) => x.toJson())),
        "main_question_id": mainQuestionId,
      };
}
