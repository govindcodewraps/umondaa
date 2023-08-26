// To parse this JSON data, do
//
//     final topBrandsModel = topBrandsModelFromJson(jsonString);

import 'dart:convert';

TopBrandsModel topBrandsModelFromJson(String str) => TopBrandsModel.fromJson(json.decode(str));

String topBrandsModelToJson(TopBrandsModel data) => json.encode(data.toJson());

class TopBrandsModel {
  List<Datum> data;
  bool success;
  int status;

  TopBrandsModel({
    this.data,
    this.success,
    this.status,
  });

  factory TopBrandsModel.fromJson(Map<String, dynamic> json) => TopBrandsModel(
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
  String logo;
  Links links;

  Datum({
    this.id,
    this.name,
    this.logo,
    this.links,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "links": links.toJson(),
  };
}

class Links {
  String products;

  Links({
    this.products,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    products: json["products"],
  );

  Map<String, dynamic> toJson() => {
    "products": products,
  };
}
