class UnitModel {
  String id;
  String unitName;
  String districtId;
  String stateId;
  String constituencyId;
  String panchayathId;
  String wardId;

  UnitModel({
    required this.id,
    required this.unitName,
    required this.districtId,
    required this.stateId,
    required this.constituencyId,
    required this.panchayathId,
    required this.wardId,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json['id'],
        unitName: json['unit_name'],
        districtId: json['district_id'],
        stateId: json['state_id'],
        constituencyId: json['constituency_id'],
        panchayathId: json['panchayath_id'],
        wardId: json['ward_id'],
      );
}
