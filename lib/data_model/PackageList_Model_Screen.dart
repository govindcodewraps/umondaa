// To parse this JSON data, do
//
//     final packageListModel = packageListModelFromJson(jsonString);

import 'dart:convert';

PackageListModel packageListModelFromJson(String str) => PackageListModel.fromJson(json.decode(str));

String packageListModelToJson(PackageListModel data) => json.encode(data.toJson());

class PackageListModel {
  List<Datum> data;
  bool success;
  int status;

  PackageListModel({
    this.data,
    this.success,
    this.status,
  });

  factory PackageListModel.fromJson(Map<String, dynamic> json) => PackageListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  int id;
  String name;
  int amount;
  int productUploadLimit;
  String logo;
  int duration;

  Datum({
    this.id,
    this.name,
    this.amount,
    this.productUploadLimit,
    this.logo,
    this.duration,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
    productUploadLimit: json["product_upload_limit"],
    logo: json["logo"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "product_upload_limit": productUploadLimit,
    "logo": logo,
    "duration": duration,
  };
}
