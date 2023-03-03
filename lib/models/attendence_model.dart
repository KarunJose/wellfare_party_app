class AttendenceModel {
  AttendenceModel({
    required this.memberId,
    required this.name,
    required this.presentCount,
    required this.absendCount,
    required this.leaveCount,
  });

  String memberId;
  String name;
  String presentCount;
  String absendCount;
  String leaveCount;

  factory AttendenceModel.fromJson(Map<String, dynamic> json) =>
      AttendenceModel(
        memberId: json["member_id"],
        name: json["name"],
        presentCount: json["present_count"],
        absendCount: json["absend_count"],
        leaveCount: json["leave_count"],
      );
}
