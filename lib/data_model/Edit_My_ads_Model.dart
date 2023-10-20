// To parse this JSON data, do
//
//     final editMyAdsListModel = editMyAdsListModelFromJson(jsonString);

import 'dart:convert';

EditMyAdsListModel editMyAdsListModelFromJson(String str) => EditMyAdsListModel.fromJson(json.decode(str));

String editMyAdsListModelToJson(EditMyAdsListModel data) => json.encode(data.toJson());

class EditMyAdsListModel {
  List<Datum> data;
  bool success;
  int status;

  EditMyAdsListModel({
    this.data,
    this.success,
    this.status,
  });

  factory EditMyAdsListModel.fromJson(Map<String, dynamic> json) => EditMyAdsListModel(
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
  String addedBy;
  int sellerId;
  int shopId;
  String shopName;
  String shopLogo;
  List<Photo> photos;
  String thumbnailImage;
  List<String> tags;
  String priceHighLow;
  List<dynamic> choiceOptions;
  List<dynamic> colors;
  bool hasDiscount;
  String discount;
  String strokedPrice;
  String mainPrice;
  int calculablePrice;
  String currencySymbol;
  int currentStock;
  String unit;
  String categoryId;
  int dismantlingStatus;
  String dismantlingFees;
  int brandId;
  int minOfferPrice;
  int minoffer;
  int rating;
  int ratingCount;
  int earnPoint;
  String description;
  String videoLink;
  Brand brand;
  String link;
  List<dynamic> wholesale;

  Datum({
    this.id,
    this.name,
    this.addedBy,
    this.sellerId,
    this.shopId,
    this.shopName,
    this.shopLogo,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.priceHighLow,
    this.choiceOptions,
    this.colors,
    this.hasDiscount,
    this.discount,
    this.strokedPrice,
    this.mainPrice,
    this.calculablePrice,
    this.currencySymbol,
    this.currentStock,
    this.unit,
    this.categoryId,
    this.dismantlingStatus,
    this.dismantlingFees,
    this.brandId,
    this.minOfferPrice,
    this.minoffer,
    this.rating,
    this.ratingCount,
    this.earnPoint,
    this.description,
    this.videoLink,
    this.brand,
    this.link,
    this.wholesale,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    addedBy: json["added_by"],
    sellerId: json["seller_id"],
    shopId: json["shop_id"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    thumbnailImage: json["thumbnail_image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    priceHighLow: json["price_high_low"],
    choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
    colors: List<dynamic>.from(json["colors"].map((x) => x)),
    hasDiscount: json["has_discount"],
    discount: json["discount"],
    strokedPrice: json["stroked_price"],
    mainPrice: json["main_price"],
    calculablePrice: json["calculable_price"],
    currencySymbol: json["currency_symbol"],
    currentStock: json["current_stock"],
    unit: json["unit"],
    categoryId: json["category_id"],
    dismantlingStatus: json["dismantling_status"],
    dismantlingFees: json["dismantling_fees"],
    brandId: json["brand_id"],
    minOfferPrice: json["min_offer_price"],
    minoffer: json["minoffer"],
    rating: json["rating"],
    ratingCount: json["rating_count"],
    earnPoint: json["earn_point"],
    description: json["description"],
    videoLink: json["video_link"],
    brand: Brand.fromJson(json["brand"]),
    link: json["link"],
    wholesale: List<dynamic>.from(json["wholesale"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedBy,
    "seller_id": sellerId,
    "shop_id": shopId,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "thumbnail_image": thumbnailImage,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "price_high_low": priceHighLow,
    "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "has_discount": hasDiscount,
    "discount": discount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "calculable_price": calculablePrice,
    "currency_symbol": currencySymbol,
    "current_stock": currentStock,
    "unit": unit,
    "category_id": categoryId,
    "dismantling_status": dismantlingStatus,
    "dismantling_fees": dismantlingFees,
    "brand_id": brandId,
    "min_offer_price": minOfferPrice,
    "minoffer": minoffer,
    "rating": rating,
    "rating_count": ratingCount,
    "earn_point": earnPoint,
    "description": description,
    "video_link": videoLink,
    "brand": brand.toJson(),
    "link": link,
    "wholesale": List<dynamic>.from(wholesale.map((x) => x)),
  };
}

class Brand {
  int id;
  String name;
  String logo;

  Brand({
    this.id,
    this.name,
    this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
  };
}

class Photo {
  String variant;
  String path;

  Photo({
    this.variant,
    this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    variant: json["variant"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "variant": variant,
    "path": path,
  };
}
