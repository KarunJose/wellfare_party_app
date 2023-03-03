import 'dart:convert';

class SubCommitteeModel {
  String id;
  String subCommitteeName;

  SubCommitteeModel({required this.id, required this.subCommitteeName});

  factory SubCommitteeModel.fromJson(Map<String, dynamic> Json) =>
      SubCommitteeModel(id: Json['id'], subCommitteeName: Json['name']);
}
