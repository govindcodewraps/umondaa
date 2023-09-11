// To parse this JSON data, do
//
//     final withdrawalamount = withdrawalamountFromJson(jsonString);

import 'dart:convert';

List<Withdrawalamount> withdrawalamountFromJson(String str) => List<Withdrawalamount>.from(json.decode(str).map((x) => Withdrawalamount.fromJson(x)));

String withdrawalamountToJson(List<Withdrawalamount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Withdrawalamount {
  double adminToPay;
  dynamic user;

  Withdrawalamount({
    this.adminToPay,
    this.user,
  });

  factory Withdrawalamount.fromJson(Map<String, dynamic> json) => Withdrawalamount(
    adminToPay: json["admin_to_pay"].toDouble(),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "admin_to_pay": adminToPay,
    "user": user,
  };
}
