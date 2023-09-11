// To parse this JSON data, do
//
//     final amountListModel = amountListModelFromJson(jsonString);

import 'dart:convert';

List<AmountListModel> amountListModelFromJson(String str) => List<AmountListModel>.from(json.decode(str).map((x) => AmountListModel.fromJson(x)));

String amountListModelToJson(List<AmountListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AmountListModel {
  int id;
  int userId;
  int amount;
  String message;
  int status;
  int viewed;
  DateTime createdAt;
  DateTime updatedAt;

  AmountListModel({
    this.id,
    this.userId,
    this.amount,
    this.message,
    this.status,
    this.viewed,
    this.createdAt,
    this.updatedAt,
  });

  factory AmountListModel.fromJson(Map<String, dynamic> json) => AmountListModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    message: json["message"],
    status: json["status"],
    viewed: json["viewed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "message": message,
    "status": status,
    "viewed": viewed,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
