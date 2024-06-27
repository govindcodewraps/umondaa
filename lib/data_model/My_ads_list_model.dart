// // To parse this JSON data, do
// //
// //     final myAdsListModel = myAdsListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// MyAdsListModel myAdsListModelFromJson(String str) => MyAdsListModel.fromJson(json.decode(str));
//
// String myAdsListModelToJson(MyAdsListModel data) => json.encode(data.toJson());
//
// class MyAdsListModel {
//   List<Datum> data;
//   MyAdsListModelLinks links;
//   Meta meta;
//   bool success;
//   int status;
//
//   MyAdsListModel({
//     this.data,
//     this.links,
//     this.meta,
//     this.success,
//     this.status,
//   });
//
//   factory MyAdsListModel.fromJson(Map<String, dynamic> json) => MyAdsListModel(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     links: MyAdsListModelLinks.fromJson(json["links"]),
//     meta: Meta.fromJson(json["meta"]),
//     success: json["success"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "links": links.toJson(),
//     "meta": meta.toJson(),
//     "success": success,
//     "status": status,
//   };
// }
//
// class Datum {
//   int id;
//   String name;
//   String thumbnailImage;
//   bool hasDiscount;
//   Discount discount;
//   String strokedPrice;
//   String mainPrice;
//   int rating;
//   int sales;
//   bool isWholesale;
//   DatumLinks links;
//
//   Datum({
//     this.id,
//     this.name,
//     this.thumbnailImage,
//     this.hasDiscount,
//     this.discount,
//     this.strokedPrice,
//     this.mainPrice,
//     this.rating,
//     this.sales,
//     this.isWholesale,
//     this.links,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     name: json["name"],
//     thumbnailImage: json["thumbnail_image"],
//     hasDiscount: json["has_discount"],
//     discount: discountValues.map[json["discount"]],
//     strokedPrice: json["stroked_price"],
//     mainPrice: json["main_price"],
//     rating: json["rating"],
//     sales: json["sales"],
//     isWholesale: json["is_wholesale"],
//     links: DatumLinks.fromJson(json["links"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "thumbnail_image": thumbnailImage,
//     "has_discount": hasDiscount,
//     "discount": discountValues.reverse[discount],
//     "stroked_price": strokedPrice,
//     "main_price": mainPrice,
//     "rating": rating,
//     "sales": sales,
//     "is_wholesale": isWholesale,
//     "links": links.toJson(),
//   };
// }
//
// enum Discount {
//   THE_0
// }
//
// final discountValues = EnumValues({
//   "-0%": Discount.THE_0
// });
//
// class DatumLinks {
//   String details;
//
//   DatumLinks({
//     this.details,
//   });
//
//   factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
//     details: json["details"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "details": details,
//   };
// }
//
// class MyAdsListModelLinks {
//   String first;
//   String last;
//   dynamic prev;
//   String next;
//
//   MyAdsListModelLinks({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });
//
//   factory MyAdsListModelLinks.fromJson(Map<String, dynamic> json) => MyAdsListModelLinks(
//     first: json["first"],
//     last: json["last"],
//     prev: json["prev"],
//     next: json["next"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first": first,
//     "last": last,
//     "prev": prev,
//     "next": next,
//   };
// }
//
// class Meta {
//   int currentPage;
//   int from;
//   int lastPage;
//   List<Link> links;
//   String path;
//   int perPage;
//   int to;
//   int total;
//
//   Meta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.links,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//     currentPage: json["current_page"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//     path: json["path"],
//     perPage: json["per_page"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "from": from,
//     "last_page": lastPage,
//     "links": List<dynamic>.from(links.map((x) => x.toJson())),
//     "path": path,
//     "per_page": perPage,
//     "to": to,
//     "total": total,
//   };
// }
//
// class Link {
//   String url;
//   String label;
//   bool active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }



// To parse this JSON data, do
//
//     final myAdsListModel = myAdsListModelFromJson(jsonString);

import 'dart:convert';

MyAdsListModel myAdsListModelFromJson(String str) => MyAdsListModel.fromJson(json.decode(str));

String myAdsListModelToJson(MyAdsListModel data) => json.encode(data.toJson());

class MyAdsListModel {
  List<Datum> data;
  MyAdsListModelLinks links;
  Meta meta;
  bool success;
  int status;

  MyAdsListModel({
     this.data,
     this.links,
     this.meta,
     this.success,
     this.status,
  });

  factory MyAdsListModel.fromJson(Map<String, dynamic> json) => MyAdsListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: MyAdsListModelLinks.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
  };
}

class Datum {
  int id;
  String name;
  String thumbnailImage;
  bool hasDiscount;
  String discount;
  String strokedPrice;
  String mainPrice;
  int rating;
  int sales;
  bool isWholesale;
  int published;
  int sold_status;
  List<Stock> stocks;
  DatumLinks links;

  Datum({
     this.id,
     this.name,
     this.thumbnailImage,
     this.hasDiscount,
     this.discount,
     this.strokedPrice,
     this.mainPrice,
     this.rating,
     this.sales,
     this.isWholesale,
     this.published,
     this.sold_status,
     this.stocks,
     this.links,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    hasDiscount: json["has_discount"],
    discount: json["discount"],
    strokedPrice: json["stroked_price"],
    mainPrice: json["main_price"],
    rating: json["rating"],
    sales: json["sales"],
    isWholesale: json["is_wholesale"],
    published: json["published"],
    sold_status: json["sold_status"],
    stocks: List<Stock>.from(json["stocks"].map((x) => Stock.fromJson(x))),
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "has_discount": hasDiscount,
    "discount": discount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "rating": rating,
    "sales": sales,
    "is_wholesale": isWholesale,
    "published": published,
    "sold_status": sold_status,
    "stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
    "links": links.toJson(),
  };
}

class DatumLinks {
  String details;

  DatumLinks({
     this.details,
  });

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class Stock {
  int id;
  int productId;
  String variant;
  dynamic sku;
  int price;
  int qty;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;

  Stock({
     this.id,
     this.productId,
     this.variant,
     this.sku,
     this.price,
     this.qty,
     this.image,
     this.createdAt,
     this.updatedAt,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    id: json["id"],
    productId: json["product_id"],
    variant: json["variant"],
    sku: json["sku"],
    price: json["price"],
    qty: json["qty"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "variant": variant,
    "sku": sku,
    "price": price,
    "qty": qty,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class MyAdsListModelLinks {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  MyAdsListModelLinks({
     this.first,
     this.last,
     this.prev,
     this.next,
  });

  factory MyAdsListModelLinks.fromJson(Map<String, dynamic> json) => MyAdsListModelLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
     this.currentPage,
     this.from,
     this.lastPage,
     this.links,
     this.path,
     this.perPage,
     this.to,
     this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String url;
  String label;
  bool active;

  Link({
     this.url,
     this.label,
     this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
