class PanchayathModel {
  String id;
  String panchayathName;
  String districtId;
  String stateId;
  String constituency;

  PanchayathModel({
    required this.id,
    required this.panchayathName,
    required this.districtId,
    required this.stateId,
    required this.constituency,
  });

  factory PanchayathModel.fromJson(Map<String, dynamic> Json) =>
      PanchayathModel(
        id: Json['id'],
        panchayathName: Json['panchayath_name'],
        districtId: Json['district_id'],
        stateId: Json['state_id'],
        constituency: Json['constituency_id'],
      );
}
