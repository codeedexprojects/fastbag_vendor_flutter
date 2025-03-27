class AddFashionProductModel {
  int? vendor;
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? description;
  String? gender;
  String? wholesalePrice;
  List<Map<String, dynamic>>? colors; // Dynamic list without a separate class
  String? material;
  bool? isActive;

  AddFashionProductModel({
    this.vendor,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.description,
    this.gender,
    this.wholesalePrice,
    this.colors,
    this.material,
    this.isActive,
  });

  AddFashionProductModel.fromJson(Map<String, dynamic> json)
      : vendor = json['vendor'],
        categoryId = json['category_id'],
        subcategoryId = json['subcategory_id'],
        name = json['name'],
        description = json['description'],
        gender = json['gender'],
        wholesalePrice = json['wholesale_price'],
        colors = (json['colors'] as List?)?.map((e) => Map<String, dynamic>.from(e)).toList(),
        material = json['material'],
        isActive = json['is_active'];

  Map<String, dynamic> toJson() => {
    'vendor': vendor,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'name': name,
    'description': description,
    'gender': gender,
    'wholesale_price': wholesalePrice,
    'colors': colors,
    'material': material,
    'is_active': isActive,
  };
}