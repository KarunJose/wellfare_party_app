class Ward {
  String id;
  String ward;
  String wardcorde;
  String districtId;
  String stateId;
  String constituencyId;
  String panchayathId;

  Ward({
    required this.id,
    required this.ward,
    required this.wardcorde,
    required this.districtId,
    required this.stateId,
    required this.constituencyId,
    required this.panchayathId,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json['id'],
        ward: json['ward_name'],
        wardcorde: json['ward_code'],
        districtId: json['district_id'],
        stateId: json['state_id'],
        constituencyId: json['constituency_id'],
        panchayathId: json['panchayath_id'],
      );
}
