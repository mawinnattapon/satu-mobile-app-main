class AppInfo {
  AppInfo();

  late String version = "";
  late String buildNumber = "";
  late String brand = "";
  late String os = "";
  late String osVersion = "";
  late String model = "";

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['buildNumber'] = buildNumber;
    data['brand'] = brand;
    data['os'] = os;
    data['osVersion'] = osVersion;
    data['model'] = model;
    return data;
  }
}
