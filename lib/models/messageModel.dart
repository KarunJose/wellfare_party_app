class MessageModel {
  MessageModel({
    required this.id,
    required this.recipientId,
    required this.subject,
    required this.message,
    required this.attachment,
    required this.createdAt,
    required this.createdBy,
  });

  String id;
  String recipientId;
  String subject;
  String message;
  dynamic attachment;
  String createdAt;
  String createdBy;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        recipientId: json["recipient_id"],
        subject: json["subject"],
        message: json["message"],
        attachment: json["attachment"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
      );
}
