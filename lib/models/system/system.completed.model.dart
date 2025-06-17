// To parse this JSON data, do
//
//     final systemCompletedModel = systemCompletedModelFromJson(jsonString);

import 'dart:convert';

SystemCompletedModel systemCompletedModelFromJson(String str) => SystemCompletedModel.fromJson(json.decode(str));

String systemCompletedModelToJson(SystemCompletedModel data) => json.encode(data.toJson());

class SystemCompletedModel {
    int id;
    int status;
    String createdAt;
    String updatedAt;

    SystemCompletedModel({
        required this.id,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SystemCompletedModel.fromJson(Map<String, dynamic> json) => SystemCompletedModel(
        id: json["id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
