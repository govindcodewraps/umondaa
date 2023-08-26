/*
// To parse this JSON data, do
//
//     final brandResponse = brandResponseFromJson(jsonString);

import 'dart:convert';

BrandsResponse brandsResponseFromJson(String str) => BrandsResponse.fromJson(json.decode(str));

String brandsResponseToJson(BrandsResponse data) => json.encode(data.toJson());

class BrandsResponse {
  List<Datum> data;
  bool success;
  int status;

  BrandsResponse({
    this.data,
    this.success,
    this.status,
  });

  factory BrandsResponse.fromJson(Map<String, dynamic> json) => BrandsResponse(
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
*/
