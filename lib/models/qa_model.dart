// To parse this JSON data, do
//
//     final qAmodel = qAmodelFromJson(jsonString);

import 'dart:convert';

import 'package:wellfare_party_app/models/qustionnaire_model.dart';

QAmodel qAmodelFromJson(String str) => QAmodel.fromJson(json.decode(str));

String qAmodelToJson(QAmodel data) => json.encode(data.toJson());

class QAmodel {
  QAmodel({
    required this.submittedOn,
    required this.submittedMonth,
    required this.reports,
    required this.status,
  });

  String submittedOn;
  String submittedMonth;
  List<QuestionnaireModel> reports;
  String? status;

  factory QAmodel.fromJson(Map<String, dynamic> json) => QAmodel(
        submittedOn: json["submitted_on"],
        submittedMonth: json["submitted_month"],
        reports: List<QuestionnaireModel>.from(
            json["reports"].map((x) => QuestionnaireModel.fromJson(x))),
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "submitted_on": submittedOn,
        "submitted_month": submittedMonth,
        "reports":
            List<QuestionnaireModel>.from(reports.map((x) => x.toJson())),
      };
}
