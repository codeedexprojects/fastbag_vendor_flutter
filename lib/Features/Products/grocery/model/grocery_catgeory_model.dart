class GroceryCategoryModel {
  int? id;
  String? name;
  String? createdAt;
  String? categoryImage;
  int? storeType;
  String? storeTypeName;

  GroceryCategoryModel(
      {this.id,
        this.name,
        this.createdAt,
        this.categoryImage,
        this.storeType,
        this.storeTypeName});

  GroceryCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    categoryImage = json['category_image'];
    storeType = json['store_type'];
    storeTypeName = json['StoreType_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['category_image'] = this.categoryImage;
    data['store_type'] = this.storeType;
    data['StoreType_name'] = this.storeTypeName;
    return data;
  }
}
