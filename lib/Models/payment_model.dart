/*
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
  int planeGrandTotal;
  CouponDiscount couponDiscount;
  CouponDiscount shippingCost;
  String subtotal;
  String tax;
  Date date;

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
    planeGrandTotal: json["plane_grand_total"],
    couponDiscount: couponDiscountValues.map[json["coupon_discount"]],
    shippingCost: couponDiscountValues.map[json["shipping_cost"]],
    subtotal: json["subtotal"],
    tax: json["tax"],
    date: dateValues.map[json["date"]],
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
    "date": dateValues.reverse[date],
  };
}

enum CouponDiscount {
  AED_000
}

final couponDiscountValues = EnumValues({
  "AED 0.00": CouponDiscount.AED_000
});

enum Date {
  THE_01092023,
  THE_30082023
}

final dateValues = EnumValues({
  "01-09-2023": Date.THE_01092023,
  "30-08-2023": Date.THE_30082023
});

enum DeliveryStatus {
  DELIVERED,
  PENDING
}

final deliveryStatusValues = EnumValues({
  "delivered": DeliveryStatus.DELIVERED,
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
  CASH_ON_DELIVERY
}

final paymentTypeValues = EnumValues({
  "Cash On Delivery": PaymentType.CASH_ON_DELIVERY
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
*/


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

  PaymenthistoryModel copyWith({
    List<Datum> data,
    bool success,
    int status,
  }) =>
      PaymenthistoryModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

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
  int planeGrandTotal;
  CouponDiscount couponDiscount;
  CouponDiscount shippingCost;
  String subtotal;
  String tax;
  Date date;

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

  Datum copyWith({
    int id,
    String code,
    int userId,
    PaymentType paymentType,
    PaymentStatus paymentStatus,
    PaymentStatusString paymentStatusString,
    DeliveryStatus deliveryStatus,
    String grandTotal,
    int planeGrandTotal,
    CouponDiscount couponDiscount,
    CouponDiscount shippingCost,
    String subtotal,
    String tax,
    Date date,
  }) =>
      Datum(
        id: id ?? this.id,
        code: code ?? this.code,
        userId: userId ?? this.userId,
        paymentType: paymentType ?? this.paymentType,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentStatusString: paymentStatusString ?? this.paymentStatusString,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        grandTotal: grandTotal ?? this.grandTotal,
        planeGrandTotal: planeGrandTotal ?? this.planeGrandTotal,
        couponDiscount: couponDiscount ?? this.couponDiscount,
        shippingCost: shippingCost ?? this.shippingCost,
        subtotal: subtotal ?? this.subtotal,
        tax: tax ?? this.tax,
        date: date ?? this.date,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    userId: json["user_id"],
    paymentType: paymentTypeValues.map[json["payment_type"]],
    paymentStatus: paymentStatusValues.map[json["payment_status"]],
    paymentStatusString: paymentStatusStringValues.map[json["payment_status_string"]],
    deliveryStatus: deliveryStatusValues.map[json["delivery_status"]],
    grandTotal: json["grand_total"],
    planeGrandTotal: json["plane_grand_total"],
    couponDiscount: couponDiscountValues.map[json["coupon_discount"]],
    shippingCost: couponDiscountValues.map[json["shipping_cost"]],
    subtotal: json["subtotal"],
    tax: json["tax"],
    date: dateValues.map[json["date"]],
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
    "date": dateValues.reverse[date],
  };
}

enum CouponDiscount {
  AED_000
}

final couponDiscountValues = EnumValues({
  "AED 0.00": CouponDiscount.AED_000
});

enum Date {
  THE_01092023,
  THE_30082023
}

final dateValues = EnumValues({
  "01-09-2023": Date.THE_01092023,
  "30-08-2023": Date.THE_30082023
});

enum DeliveryStatus {
  DELIVERED,
  PENDING
}

final deliveryStatusValues = EnumValues({
  "delivered": DeliveryStatus.DELIVERED,
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
  CASH_ON_DELIVERY
}

final paymentTypeValues = EnumValues({
  "Cash On Delivery": PaymentType.CASH_ON_DELIVERY
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
