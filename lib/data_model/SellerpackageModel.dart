// To parse this JSON data, do
//
//     final sellerpackagemodel = sellerpackagemodelFromJson(jsonString);

import 'dart:convert';

Sellerpackagemodel sellerpackagemodelFromJson(String str) => Sellerpackagemodel.fromJson(json.decode(str));

String sellerpackagemodelToJson(Sellerpackagemodel data) => json.encode(data.toJson());

class Sellerpackagemodel {
  List<Datum> data;
  bool success;
  int status;

  Sellerpackagemodel({
    this.data,
    this.success,
    this.status,
  });

  factory Sellerpackagemodel.fromJson(Map<String, dynamic> json) => Sellerpackagemodel(
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
