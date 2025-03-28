class GrocerySubCategoryModel {
  final int id;
  final String vendor;
  final int category;
  final String categoryName;
  final String name;
  final String? subcategoryImage;
  final bool enableSubcategory;
  final String createdAt;

  GrocerySubCategoryModel({
    required this.id,
    required this.vendor,
    required this.category,
    required this.categoryName,
    required this.name,
    this.subcategoryImage,
    required this.enableSubcategory,
    required this.createdAt,
  });

  factory GrocerySubCategoryModel.fromJson(Map<String, dynamic> json) {
    return GrocerySubCategoryModel(
      id: json['id'],
      vendor: json['vendor'],
      category: json['category'],
      categoryName: json['category_name'],
      name: json['name'],
      subcategoryImage: json['subcategory_image'],
      enableSubcategory: json['enable_subcategory'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vendor": vendor,
      "category": category,
      "category_name": categoryName,
      "name": name,
      "subcategory_image": subcategoryImage,
      "enable_subcategory": enableSubcategory,
      "created_at": createdAt,
    };
  }

  static List<GrocerySubCategoryModel> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => GrocerySubCategoryModel.fromJson(json))
        .toList();
  }
}
