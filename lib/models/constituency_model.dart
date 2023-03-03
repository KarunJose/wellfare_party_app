class ConstituencyModel {
  String id;
  String constituencyName;
  String districtId;
  String stateId;

  ConstituencyModel({
    required this.constituencyName,
    required this.id,
    required this.districtId,
    required this.stateId,
  });

  factory ConstituencyModel.fromJson(Map<String, dynamic> json) =>
      ConstituencyModel(
        constituencyName: json["constituency_name"],
        id: json["id"],
        districtId: json['district_id'],
        stateId: json['state_id'],
      );
}
