// class FoodSubCategoryModel {
//   int? count;
//   int? totalPages;
//   dynamic next;
//   dynamic previous;
//   List<FoodCategoryBySubcategoryModel>? results;
//
//   FoodSubCategoryModel({this.count,this.totalPages, this.next, this.previous, this.results});
//
//   FoodSubCategoryModel.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     totalPages = json['total_pages'];
//     next = json['next'];
//     previous = json['previous'];
//     if (json['results'] != null) {
//       results = <FoodCategoryBySubcategoryModel>[];
//       json['results'].forEach((v) {
//         results!.add(new FoodCategoryBySubcategoryModel .fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['total_pages'] = this.totalPages;
//     data['next'] = this.next;
//     data['previous'] = this.previous;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class FoodCategoryBySubcategoryModel  {
//   int? id;
//   String? name;
//   String? subcategoryImage;
//   int? category;
//   String? categoryName;
//   bool? enableSubcategory;
//   int? vendor;
//   String? vendorName;
//
//   FoodCategoryBySubcategoryModel (
//       {this.id,
//         this.name,
//         this.subcategoryImage,
//         this.category,
//         this.categoryName,
//         this.enableSubcategory,
//         this.vendor,
//         this.vendorName});
//
//   FoodCategoryBySubcategoryModel .fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     subcategoryImage = json['subcategory_image'];
//     category = json['category'];
//     categoryName = json['category_name'];
//     enableSubcategory = json['enable_subcategory'];
//     vendor = json['vendor'];
//     vendorName = json['vendor_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['subcategory_image'] = this.subcategoryImage;
//     data['category'] = this.category;
//     data['category_name'] = this.categoryName;
//     data['enable_subcategory'] = this.enableSubcategory;
//     data['vendor'] = this.vendor;
//     data['vendor_name'] = this.vendorName;
//     return data;
//   }
// }
class FoodSubCategoryModel {
  int? count;
  int? totalPages;
  dynamic next;
  dynamic previous;
  List<FoodCategoryBySubcategoryModel>? results;

  FoodSubCategoryModel({this.count, this.totalPages, this.next, this.previous, this.results});

  FoodSubCategoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <FoodCategoryBySubcategoryModel>[];
      json['results'].forEach((v) {
        results!.add(new FoodCategoryBySubcategoryModel.fromJson(v));
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

class FoodCategoryBySubcategoryModel {
  int? id;
  String? name;
  String? subcategoryImage;
  int? category;
  String? categoryName;
  bool? enableSubcategory;
  int? vendor;
  String? vendorName;

  FoodCategoryBySubcategoryModel(
      {this.id,
        this.name,
        this.subcategoryImage,
        this.category,
        this.categoryName,
        this.enableSubcategory,
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
