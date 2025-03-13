// ignore_for_file: non_constant_identifier_names

class SubCategoryModel {
  final int id;
  final int categoryId;
  final String name;
  final String sub_category_image;
  final bool is_enabled;
  final dynamic vendor;

  SubCategoryModel(
      {required this.categoryId,
      required this.is_enabled,
      required this.name,
      required this.sub_category_image,
      required this.id,
      required this.vendor});

  factory SubCategoryModel.fromMap(Map<String, dynamic> subCategoryMap) {
    return SubCategoryModel(
        id: subCategoryMap["id"],
        categoryId: subCategoryMap["category"],
        is_enabled: subCategoryMap["enable_subcategory"],
        name: subCategoryMap["name"],
        sub_category_image: subCategoryMap["subcategory_image"] ?? "",
        vendor: subCategoryMap["vendor"]);
  }
}
