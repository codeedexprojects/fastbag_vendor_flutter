class FoodCategoryBySubcategoryModel {
  int? id;
  String? name;
  String? subcategoryImage;
  int? category;
  String? categoryName;
  bool? enableSubcategory;
  dynamic vendor;
  String? vendorName;

  FoodCategoryBySubcategoryModel(
      {this.id,
        this.name,
        required this.subcategoryImage,
        required this.category,
        this.categoryName,
        required this.enableSubcategory,
        this.vendor,
        this.vendorName});

  FoodCategoryBySubcategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subcategoryImage = json['subcategory_image'];
    category = json['category'];
    categoryName = json['category_name'];
    enableSubcategory = json['enable_subcategory'];
    vendor = json['vendor'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subcategory_image'] = this.subcategoryImage;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['enable_subcategory'] = this.enableSubcategory;
    data['vendor'] = this.vendor;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}
