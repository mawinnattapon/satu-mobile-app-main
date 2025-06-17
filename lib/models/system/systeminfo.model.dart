import 'dart:convert';

List<SystemInfoModel> systemInfoModelFromJson(String str) =>
    List<SystemInfoModel>.from(json.decode(str).map((x) => SystemInfoModel.fromJson(x)));

String systemInfoModelToJson(List<SystemInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SystemInfoModel {
  int id;
  String name;
  bool allowRepeat;
  int? lastId;
  String? lastDate;
  int? lastStatus;

  SystemInfoModel({
    required this.id,
    required this.name,
    required this.allowRepeat,
    this.lastId,
    this.lastDate,
    this.lastStatus,
  });

  factory SystemInfoModel.fromJson(Map<String, dynamic> json) => SystemInfoModel(
        id: json["id"],
        name: json["name"],
        allowRepeat: json["allow_repeat"],
        lastId: json["last_id"],
        lastDate: json["last_date"],
        lastStatus: json["last_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "allow_repeat": allowRepeat,
        "last_id": lastId,
        "last_date": lastDate,
        "last_status": lastStatus,
      };
}
