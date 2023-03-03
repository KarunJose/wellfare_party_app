class ReportModel {
  ReportModel({
    required this.id,
    required this.bearerType,
    required this.stateId,
    required this.districtId,
    required this.constituencyId,
    required this.panchayathId,
    required this.wardId,
    required this.unitId,
    required this.memberId,
    required this.designationId,
    required this.stateName,
    required this.districtName,
    required this.constituencyName,
    required this.panchayathName,
    required this.wardName,
    required this.unitName,
    required this.memberName,
    required this.designationName,
  });

  String id;
  String bearerType;
  String stateId;
  String districtId;
  String constituencyId;
  String panchayathId;
  String wardId;
  String unitId;
  String? memberId;
  String designationId;
  String stateName;
  dynamic districtName;
  dynamic constituencyName;
  dynamic panchayathName;
  dynamic wardName;
  dynamic unitName;
  String? memberName;
  String designationName;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"],
        bearerType: json["bearer_type"],
        stateId: json["state_id"],
        districtId: json["district_id"],
        constituencyId: json["constituency_id"],
        panchayathId: json["panchayath_id"],
        wardId: json["ward_id"],
        unitId: json["unit_id"],
        memberId: json["member_id"],
        designationId: json["designation_id"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        constituencyName: json["constituency_name"],
        panchayathName: json["panchayath_name"],
        wardName: json["ward_name"],
        unitName: json["unit_name"],
        memberName: json["member_name"],
        designationName: json["designation_name"],
      );
}
