// To parse this JSON data, do
//
//     final assmScanModel = assmScanModelFromJson(jsonString);

import 'dart:convert';

ScanModel assmScanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String assmScanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    int? id;
    String? name;
    String? eqmNo;
    String? eqmQrcode;
    String? eqmBarcode;
    String? altNo;
    String? altQrcode;
    String? altBarcode;
    int? categoryId;
    String? categoryName;
    int? companyId;
    String? companyName;
    int? projectId;
    String? projectName;
    String? purchaseDate;
    String? installationDate;
    String? modelname;
    int? active;
    List<dynamic>? photos;

    ScanModel({
        this.id,
        this.name,
        this.eqmNo,
        this.eqmQrcode,
        this.eqmBarcode,
        this.altNo,
        this.altQrcode,
        this.altBarcode,
        this.categoryId,
        this.categoryName,
        this.companyId,
        this.companyName,
        this.projectId,
        this.projectName,
        this.purchaseDate,
        this.installationDate,
        this.active,
        this.photos,
        this.modelname,
    });

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        name: json["name"],
        eqmNo: json["eqm_no"],
        eqmQrcode: json["eqm_qrcode"],
        eqmBarcode: json["eqm_barcode"],
        altNo: json["alt_no"],
        altQrcode: json["alt_qrcode"],
        altBarcode: json["alt_barcode"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        purchaseDate: json["purchase_date"],
        installationDate: json["installation_date"],
        active: json["active"],
        modelname: json["model_name"],
        photos: List<dynamic>.from(json["photos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "eqm_no": eqmNo,
        "eqm_qrcode": eqmQrcode,
        "eqm_barcode": eqmBarcode,
        "alt_no": altNo,
        "alt_qrcode": altQrcode,
        "alt_barcode": altBarcode,
        "category_id": categoryId,
        "category_name": categoryName,
        "company_id": companyId,
        "company_name": companyName,
        "project_id": projectId,
        "project_name": projectName,
        "purchase_date": purchaseDate,
        "installation_date": installationDate,
        "active": active,
        "model_name": modelname,
        "photos": List<dynamic>.from(photos!.map((x) => x)),
    };
}
