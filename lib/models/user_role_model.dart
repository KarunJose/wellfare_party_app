class UserRoleModel {
  UserRoleModel({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.status,
    required this.usertype,
    required this.display,
  });

  String id;
  String name;
  DateTime dateTime;
  String status;
  String usertype;
  String display;

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        id: json["id"],
        name: json["name"],
        dateTime: DateTime.parse(json["date_time"]),
        status: json["status"],
        usertype: json["usertype"],
        display: json["display"],
      );
}
