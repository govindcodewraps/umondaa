// To parse this JSON data, do
//
//     final paymenthistoryModel = paymenthistoryModelFromJson(jsonString);

import 'dart:convert';

PaymenthistoryModel paymenthistoryModelFromJson(String str) => PaymenthistoryModel.fromJson(json.decode(str));

String paymenthistoryModelToJson(PaymenthistoryModel data) => json.encode(data.toJson());

class PaymenthistoryModel {
  List<Datum> data;
  bool success;
  int status;

  PaymenthistoryModel({
    this.data,
    this.success,
    this.status,
  });

  factory PaymenthistoryModel.fromJson(Map<String, dynamic> json) => PaymenthistoryModel(
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
  String code;
  int userId;
  PaymentType paymentType;
  PaymentStatus paymentStatus;
  PaymentStatusString paymentStatusString;
  DeliveryStatus deliveryStatus;
  String grandTotal;
  double planeGrandTotal;
  CouponDiscount couponDiscount;
  CouponDiscount shippingCost;
  String subtotal;
  String tax;
  String date;

  Datum({
    this.id,
    this.code,
    this.userId,
    this.paymentType,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.grandTotal,
    this.planeGrandTotal,
    this.couponDiscount,
    this.shippingCost,
    this.subtotal,
    this.tax,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    userId: json["user_id"],
    paymentType: paymentTypeValues.map[json["payment_type"]],
    paymentStatus: paymentStatusValues.map[json["payment_status"]],
    paymentStatusString: paymentStatusStringValues.map[json["payment_status_string"]],
    deliveryStatus: deliveryStatusValues.map[json["delivery_status"]],
    grandTotal: json["grand_total"],
    planeGrandTotal: json["plane_grand_total"].toDouble(),
    couponDiscount: couponDiscountValues.map[json["coupon_discount"]],
    shippingCost: couponDiscountValues.map[json["shipping_cost"]],
    subtotal: json["subtotal"],
    tax: json["tax"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "user_id": userId,
    "payment_type": paymentTypeValues.reverse[paymentType],
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "payment_status_string": paymentStatusStringValues.reverse[paymentStatusString],
    "delivery_status": deliveryStatusValues.reverse[deliveryStatus],
    "grand_total": grandTotal,
    "plane_grand_total": planeGrandTotal,
    "coupon_discount": couponDiscountValues.reverse[couponDiscount],
    "shipping_cost": couponDiscountValues.reverse[shippingCost],
    "subtotal": subtotal,
    "tax": tax,
    "date": date,
  };
}

enum CouponDiscount {
  AED_000
}

final couponDiscountValues = EnumValues({
  "AED 0.00": CouponDiscount.AED_000
});

enum DeliveryStatus {
  CONFIRMED,
  PENDING
}

final deliveryStatusValues = EnumValues({
  "confirmed": DeliveryStatus.CONFIRMED,
  "pending": DeliveryStatus.PENDING
});

enum PaymentStatus {
  PAID,
  UNPAID
}

final paymentStatusValues = EnumValues({
  "paid": PaymentStatus.PAID,
  "unpaid": PaymentStatus.UNPAID
});

enum PaymentStatusString {
  PAID,
  UNPAID
}

final paymentStatusStringValues = EnumValues({
  "Paid": PaymentStatusString.PAID,
  "Unpaid": PaymentStatusString.UNPAID
});

enum PaymentType {
  CASH_PAYMENT,
  STRIPE,
  WALLET
}

final paymentTypeValues = EnumValues({
  "Cash Payment": PaymentType.CASH_PAYMENT,
  "Stripe": PaymentType.STRIPE,
  "Wallet": PaymentType.WALLET
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
