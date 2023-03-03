import 'package:intl/intl.dart';
import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    required this.id,
    required this.date,
    required this.heading,
    required this.text,
    required this.sortOrder,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    required this.type,
  });

  String id;
  String date;
  String heading;
  String text;
  String sortOrder;
  String status;
  DateTime createdAt;
  String createdBy;
  String type;

  factory Notification.fromJson(Map<String, dynamic> json) {
    Notification notification = Notification(
        id: json["id"],
        date: json["date"],
        heading: json["heading"],
        text: json["text"],
        sortOrder: json["sort_order"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        type: json["type"]);

    var strToDateTime = DateTime.parse(json["date"].toString());
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat("dd-MM-yyyy");

    notification.date = newFormat.format(convertLocal);

    return notification;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "heading": heading,
        "text": text,
        "sort_order": sortOrder,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "type": type,
      };
}
