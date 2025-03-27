class SubCategoryModel {
  int? count;
  String? next;
  Null? previous;
  List<CategoryBySubCategoryModel>? results;

  SubCategoryModel(
      {this.count, this.next, this.previous, this.results});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <CategoryBySubCategoryModel>[];
      json['results'].forEach((v) {
        results!.add(new CategoryBySubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryBySubCategoryModel {
  int? id;
  String? vendor;
  int? category;
  String? categoryName;
  String? name;
  String? description;
  String? subcategoryImage;
  bool? enableSubcategory;
  String? createdAt;

  CategoryBySubCategoryModel(
      {this.id,
        this.vendor,
        this.category,
        this.categoryName,
        this.name,
        this.description,
        this.subcategoryImage,
        this.enableSubcategory,
        this.createdAt});

  CategoryBySubCategoryModel.fromJson(Map<String, dynamic> json) {
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
