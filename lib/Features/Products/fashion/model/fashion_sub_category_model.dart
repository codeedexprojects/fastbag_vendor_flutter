class FashionSubCategoryModel {
  int? id;
  dynamic vendor;
  int? category;
  String? categoryName;
  String? name;
  String? subcategoryImage;
  bool? enableSubcategory;
  String? createdAt;
  String? description;

  FashionSubCategoryModel(
      {this.id,
        this.vendor,
        this.category,
        this.categoryName,
        this.name,
        this.subcategoryImage,
        this.enableSubcategory,
        this.createdAt,
        this.description,
      });

  FashionSubCategoryModel.fromJson(Map<String, dynamic> json, ) {
    id = json['id'];
    vendor = json['vendor'];
    category = json['category'];
    categoryName = json['category_name'];
    name = json['name'];
    subcategoryImage = json['subcategory_image'];
    enableSubcategory = json['enable_subcategory'];
    createdAt = json['created_at'];
    description=json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor'] = this.vendor;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['name'] = this.name;
    data['subcategory_image'] = this.subcategoryImage;
    data['enable_subcategory'] = this.enableSubcategory;
    data['created_at'] = this.createdAt;
    data['description']=this.description;
    return data;
  }
}
