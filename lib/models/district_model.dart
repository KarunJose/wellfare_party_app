class DistrictModel {
  String districtId;
  String districtName;
  String stateId;

  DistrictModel({
    required this.districtName,
    required this.districtId,
    required this.stateId,
  });

  factory DistrictModel.fromjson(Map<String, dynamic> json) => DistrictModel(
      districtName: json['district_name'],
      districtId: json['id'],
      stateId: json['state_id']);
}
