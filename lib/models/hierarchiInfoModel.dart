class HierarchyInfoModel {
  HierarchyInfoModel({
    required this.title,
    required this.total,
    required this.admins,
    required this.officeBearers,
    required this.reports,
  });

  String title;
  int total;
  int admins;
  int officeBearers;
  int reports;

  factory HierarchyInfoModel.fromJson(Map<String, dynamic> json) =>
      HierarchyInfoModel(
        title: json["title"],
        total: json["total"],
        admins: json["admins"],
        officeBearers: json["office_bearers"],
        reports: json["reports"],
      );
}
