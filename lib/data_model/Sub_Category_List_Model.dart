// To parse this JSON data, do
//
//     final subCategoryListModel = subCategoryListModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryListModel> subCategoryListModelFromJson(String str) => List<SubCategoryListModel>.from(json.decode(str).map((x) => SubCategoryListModel.fromJson(x)));

String subCategoryListModelToJson(List<SubCategoryListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryListModel {
  int id;
  int parentId;
  int level;
  String name;
  int orderLevel;
  int commisionRate;
  dynamic banner;
  dynamic icon;
  int featured;
  int top;
  int digital;
  String slug;
  dynamic metaTitle;
  dynamic metaDescription;
  int dismantlingStatus;
  String dismantlingFees;
  DateTime createdAt;
  DateTime updatedAt;
  List<CategoryTranslation> categoryTranslations;

  SubCategoryListModel({
    this.id,
    this.parentId,
    this.level,
    this.name,
    this.orderLevel,
    this.commisionRate,
    this.banner,
    this.icon,
    this.featured,
    this.top,
    this.digital,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.dismantlingStatus,
    this.dismantlingFees,
    this.createdAt,
    this.updatedAt,
    this.categoryTranslations,
  });

  factory SubCategoryListModel.fromJson(Map<String, dynamic> json) => SubCategoryListModel(
    id: json["id"],
    parentId: json["parent_id"],
    level: json["level"],
    name: json["name"],
    orderLevel: json["order_level"],
    commisionRate: json["commision_rate"],
    banner: json["banner"],
    icon: json["icon"],
    featured: json["featured"],
    top: json["top"],
    digital: json["digital"],
    slug: json["slug"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    dismantlingStatus: json["dismantling_status"],
    dismantlingFees: json["dismantling_fees"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    categoryTranslations: List<CategoryTranslation>.from(json["category_translations"].map((x) => CategoryTranslation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "level": level,
    "name": name,
    "order_level": orderLevel,
    "commision_rate": commisionRate,
    "banner": banner,
    "icon": icon,
    "featured": featured,
    "top": top,
    "digital": digital,
    "slug": slug,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "dismantling_status": dismantlingStatus,
    "dismantling_fees": dismantlingFees,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category_translations": List<dynamic>.from(categoryTranslations.map((x) => x.toJson())),
  };
}

class CategoryTranslation {
  int id;
  int categoryId;
  String name;
  String lang;
  DateTime createdAt;
  DateTime updatedAt;

  CategoryTranslation({
    this.id,
    this.categoryId,
    this.name,
    this.lang,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) => CategoryTranslation(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    lang: json["lang"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "lang": lang,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
