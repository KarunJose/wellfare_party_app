class SubcommitteeReportModel {
  SubcommitteeReportModel({
    required this.id,
    required this.bearerType,
    required this.subcommitteeId,
    required this.stateId,
    required this.districtId,
    required this.constituencyId,
    required this.panchayathId,
    required this.wardId,
    required this.unitId,
    required this.designationId,
    required this.name,
    required this.address,
    required this.phone,
    required this.stateName,
    required this.districtName,
    required this.constituencyName,
    required this.panchayathName,
    required this.wardName,
    required this.unitName,
    required this.designationName,
    required this.subcommittee,
  });

  String id;
  String bearerType;
  String subcommitteeId;
  String stateId;
  String districtId;
  String constituencyId;
  String panchayathId;
  String wardId;
  String unitId;
  String designationId;
  String name;
  String address;
  String phone;
  String stateName;
  String? districtName;
  dynamic constituencyName;
  dynamic panchayathName;
  dynamic wardName;
  dynamic unitName;
  String designationName;
  String subcommittee;

  factory SubcommitteeReportModel.fromJson(Map<String, dynamic> json) =>
      SubcommitteeReportModel(
        id: json["id"],
        bearerType: json["bearer_type"],
        subcommitteeId: json["subcommittee_id"],
        stateId: json["state_id"],
        districtId: json["district_id"],
        constituencyId: json["constituency_id"],
        panchayathId: json["panchayath_id"],
        wardId: json["ward_id"],
        unitId: json["unit_id"],
        designationId: json["designation_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        constituencyName: json["constituency_name"],
        panchayathName: json["panchayath_name"],
        wardName: json["ward_name"],
        unitName: json["unit_name"],
        designationName: json["designation_name"],
        subcommittee: json["subcommittee"],
      );
}
