class StateModel {
  String id;
  String stateName;

  StateModel({required this.stateName, required this.id});

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      StateModel(stateName: json['state_name'], id: json['id']);
}
