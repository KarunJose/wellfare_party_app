class Designation {
  String id;
  String designationName;

  Designation({required this.designationName, required this.id});

  factory Designation.fromJson(Map<String, dynamic> json) =>
      Designation(designationName: json['designation_name'], id: json['id']);
}
