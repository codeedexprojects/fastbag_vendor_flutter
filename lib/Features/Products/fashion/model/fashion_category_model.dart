// ignore_for_file: non_constant_identifier_names
class FashionCategoryModel {
  final int id;
  final String name;
  final String category_image;



  FashionCategoryModel(
      {required this.id,
      required this.name,
      required this.category_image,
      });

  factory FashionCategoryModel.fromMap(Map<String, dynamic> categoryMap) {
    return FashionCategoryModel(
        id: categoryMap["id"],
        name: categoryMap["name"],
        category_image: categoryMap["category_image"],
       );
  }
}
