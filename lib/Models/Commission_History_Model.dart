// // To parse this JSON data, do
// //
// //     final commisionHistoryModel = commisionHistoryModelFromJson(jsonString);
//
// import 'dart:convert';
//
// CommisionHistoryModel commisionHistoryModelFromJson(String str) => CommisionHistoryModel.fromJson(json.decode(str));
//
// String commisionHistoryModelToJson(CommisionHistoryModel data) => json.encode(data.toJson());
//
// class CommisionHistoryModel {
//   List<Datum> data;
//   bool success;
//   int status;
//
//   CommisionHistoryModel({
//     this.data,
//     this.success,
//     this.status,
//   });
//
//   CommisionHistoryModel copyWith({
//     List<Datum> data,
//     bool success,
//     int status,
//   }) =>
//       CommisionHistoryModel(
//         data: data ?? this.data,
//         success: success ?? this.success,
//         status: status ?? this.status,
//       );
//
//   factory CommisionHistoryModel.fromJson(Map<String, dynamic> json) => CommisionHistoryModel(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     success: json["success"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "success": success,
//     "status": status,
//   };
// }
//
// class Datum {
//   int id;
//   int orderId;
//   int userId;
//   double sellerEarning;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   Datum({
//     this.id,
//     this.orderId,
//     this.userId,
//     this.sellerEarning,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Datum copyWith({
//     int id,
//     int orderId,
//     int userId,
//     double sellerEarning,
//     DateTime createdAt,
//     DateTime updatedAt,
//   }) =>
//       Datum(
//         id: id ?? this.id,
//         orderId: orderId ?? this.orderId,
//         userId: userId ?? this.userId,
//         sellerEarning: sellerEarning ?? this.sellerEarning,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     orderId: json["order_id"],
//     userId: json["user_id"],
//     sellerEarning: json["seller_earning"].toDouble(),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "order_id": orderId,
//     "user_id": userId,
//     "seller_earning": sellerEarning,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }




// To parse this JSON data, do
//
//     final commisionHistoryModel = commisionHistoryModelFromJson(jsonString);

import 'dart:convert';

CommisionHistoryModel commisionHistoryModelFromJson(String str) => CommisionHistoryModel.fromJson(json.decode(str));

String commisionHistoryModelToJson(CommisionHistoryModel data) => json.encode(data.toJson());

class CommisionHistoryModel {
  List<Datum> data;
  bool success;
  int status;

  CommisionHistoryModel({
    this.data,
    this.success,
    this.status,
  });

  factory CommisionHistoryModel.fromJson(Map<String, dynamic> json) => CommisionHistoryModel(
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
  int orderId;
  int userId;
  String orderCode;
  double commissionPaid;
  double sellerEarning;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.orderId,
    this.userId,
    this.orderCode,
    this.commissionPaid,
    this.sellerEarning,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    orderCode: json["order_code"],
    commissionPaid: json["commission_paid"].toDouble(),
    sellerEarning: json["seller_earning"].toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "order_code": orderCode,
    "commission_paid": commissionPaid,
    "seller_earning": sellerEarning,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
