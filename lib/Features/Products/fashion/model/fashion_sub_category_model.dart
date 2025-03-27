class FaSubCategoryModel {
  int? count;
  int? totalPages;
  String? next;
  dynamic previous;
  List<FashionSubCategoryModel>? results;

  FaSubCategoryModel(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  FaSubCategoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <FashionSubCategoryModel>[];
      json['results'].forEach((v) {
        results!.add(new FashionSubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FashionSubCategoryModel {
  int? id;
  String? vendor;
  int? category;
  String? categoryName;
  String? name;
  String? description;
  String? subcategoryImage;
  bool? enableSubcategory;
  String? createdAt;

  FashionSubCategoryModel(
      {this.id,
      this.vendor,
      this.category,
      this.categoryName,
      this.name,
      this.description,
      this.subcategoryImage,
      this.enableSubcategory,
      this.createdAt});

  FashionSubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'];
    category = json['category'];
    categoryName = json['category_name'];
    name = json['name'];
    description = json['description'];
    subcategoryImage = json['subcategory_image'];
    enableSubcategory = json['enable_subcategory'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor'] = this.vendor;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['subcategory_image'] = this.subcategoryImage;
    data['enable_subcategory'] = this.enableSubcategory;
    data['created_at'] = this.createdAt;
    return data;
  }
}
