import 'dart:typed_data';

class AppDetail {
  String name;
  Uint8List? icon;
  String packageName;

  AppDetail({
    required this.name,
    required this.icon,
    required this.packageName,
  });

  factory AppDetail.create(dynamic data) {
    return AppDetail(
      name: data["name"],
      icon: data["icon"],
      packageName: data["packageName"],
    );
  }

  static List<AppDetail> parseList(dynamic apps) {
    if (apps == null || apps is! List || apps.isEmpty) return [];
    final List<AppDetail> appDetailList = apps
        .where((element) =>
            element is Map &&
            element.containsKey("name") &&
            element.containsKey("packageName"))
        .map((app) => AppDetail.create(app))
        .toList();
    appDetailList.sort((a, b) => a.name.compareTo(b.name));
    return appDetailList;
  }
}
