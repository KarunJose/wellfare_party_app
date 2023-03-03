class Position {
  String id;
  String position;

  Position({
    required this.id,
    required this.position,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      Position(id: json['id'], position: json['position_name']);
}
