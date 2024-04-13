
class allcategoryModel {
  int id;
  int parentId;
  int level;
  String name;
  int orderLevel;
  int commisionRate;
  String banner;
  String icon;
  int featured;
  int top;
  int digital;
  String slug;
  String metaTitle;
  String metaDescription;
  int dismantlingStatus;
  Null dismantlingFees;
  String createdAt;
  String updatedAt;
  List<CategoryTranslations> categoryTranslations;
  List<ChildrenCategories> childrenCategories;

  allcategoryModel(
      {this.id,
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
        this.childrenCategories});

  allcategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    level = json['level'];
    name = json['name'];
    orderLevel = json['order_level'];
    commisionRate = json['commision_rate'];
    banner = json['banner'];
    icon = json['icon'];
    featured = json['featured'];
    top = json['top'];
    digital = json['digital'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    dismantlingStatus = json['dismantling_status'];
    dismantlingFees = json['dismantling_fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category_translations'] != null) {
      categoryTranslations = <CategoryTranslations>[];
      json['category_translations'].forEach((v) {
        categoryTranslations.add(new CategoryTranslations.fromJson(v));
      });
    }
    if (json['children_categories'] != null) {
      childrenCategories = <ChildrenCategories>[];
      json['children_categories'].forEach((v) {
        childrenCategories.add(new ChildrenCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['level'] = this.level;
    data['name'] = this.name;
    data['order_level'] = this.orderLevel;
    data['commision_rate'] = this.commisionRate;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    data['featured'] = this.featured;
    data['top'] = this.top;
    data['digital'] = this.digital;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['dismantling_status'] = this.dismantlingStatus;
    data['dismantling_fees'] = this.dismantlingFees;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categoryTranslations != null) {
      data['category_translations'] =
          this.categoryTranslations.map((v) => v.toJson()).toList();
    }
    if (this.childrenCategories != null) {
      data['children_categories'] =
          this.childrenCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryTranslations {
  int id;
  int categoryId;
  String name;
  String lang;
  String createdAt;
  String updatedAt;

  CategoryTranslations(
      {this.id,
        this.categoryId,
        this.name,
        this.lang,
        this.createdAt,
        this.updatedAt});

  CategoryTranslations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    lang = json['lang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['lang'] = this.lang;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ChildrenCategories {
  int id;
  int parentId;
  int level;
  String name;
  int orderLevel;
  int commisionRate;
  Null banner;
  Null icon;
  int featured;
  int top;
  int digital;
  String slug;
  String metaTitle;
  String metaDescription;
  int dismantlingStatus;
  Null dismantlingFees;
  String createdAt;
  String updatedAt;
  List<CategoryTranslations> categoryTranslations;
  List<Categories> categories;

  ChildrenCategories(
      {this.id,
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
        this.categories});

  ChildrenCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    level = json['level'];
    name = json['name'];
    orderLevel = json['order_level'];
    commisionRate = json['commision_rate'];
    banner = json['banner'];
    icon = json['icon'];
    featured = json['featured'];
    top = json['top'];
    digital = json['digital'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    dismantlingStatus = json['dismantling_status'];
    dismantlingFees = json['dismantling_fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category_translations'] != null) {
      categoryTranslations = <CategoryTranslations>[];
      json['category_translations'].forEach((v) {
        categoryTranslations.add(new CategoryTranslations.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['level'] = this.level;
    data['name'] = this.name;
    data['order_level'] = this.orderLevel;
    data['commision_rate'] = this.commisionRate;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    data['featured'] = this.featured;
    data['top'] = this.top;
    data['digital'] = this.digital;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['dismantling_status'] = this.dismantlingStatus;
    data['dismantling_fees'] = this.dismantlingFees;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categoryTranslations != null) {
      data['category_translations'] =
          this.categoryTranslations.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  int parentId;
  int level;
  String name;
  int orderLevel;
  int commisionRate;
  Null banner;
  Null icon;
  int featured;
  int top;
  int digital;
  String slug;
  String metaTitle;
  String metaDescription;
  int dismantlingStatus;
  String dismantlingFees;
  String createdAt;
  String updatedAt;
  List<CategoryTranslations> categoryTranslations;

  Categories(
      {this.id,
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
        this.categoryTranslations});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    level = json['level'];
    name = json['name'];
    orderLevel = json['order_level'];
    commisionRate = json['commision_rate'];
    banner = json['banner'];
    icon = json['icon'];
    featured = json['featured'];
    top = json['top'];
    digital = json['digital'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    dismantlingStatus = json['dismantling_status'];
    dismantlingFees = json['dismantling_fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category_translations'] != null) {
      categoryTranslations = <CategoryTranslations>[];
      json['category_translations'].forEach((v) {
        categoryTranslations.add(new CategoryTranslations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['level'] = this.level;
    data['name'] = this.name;
    data['order_level'] = this.orderLevel;
    data['commision_rate'] = this.commisionRate;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    data['featured'] = this.featured;
    data['top'] = this.top;
    data['digital'] = this.digital;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['dismantling_status'] = this.dismantlingStatus;
    data['dismantling_fees'] = this.dismantlingFees;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categoryTranslations != null) {
      data['category_translations'] =
          this.categoryTranslations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}