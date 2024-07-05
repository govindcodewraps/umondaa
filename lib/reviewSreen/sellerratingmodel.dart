// To parse this JSON data, do
//
//     final sellerrating = sellerratingFromJson(jsonString);

import 'dart:convert';

Sellerrating sellerratingFromJson(String str) => Sellerrating.fromJson(json.decode(str));

String sellerratingToJson(Sellerrating data) => json.encode(data.toJson());

class Sellerrating {
  List<Product> products;
  int averageRating;

  Sellerrating({
    this.products,
    this.averageRating,
  });

  factory Sellerrating.fromJson(Map<String, dynamic> json) => Sellerrating(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "average_rating": averageRating,
  };
}

class Product {
  int productId;
  String productName;
  int productRating;

  Product({
    this.productId,
    this.productName,
    this.productRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    productName: json["product_name"],
    productRating: json["product_rating"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_rating": productRating,
  };
}
