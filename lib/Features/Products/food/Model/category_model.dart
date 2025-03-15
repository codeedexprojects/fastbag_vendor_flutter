// ignore_for_file: non_constant_identifier_names
class CategoryModel {
  final int id;
  final String name;
  final String category_image;
  
  

  CategoryModel(
      {required this.id,
      required this.name,
      required this.category_image,
      });

  factory CategoryModel.fromMap(Map<String, dynamic> categoryMap) {
    return CategoryModel(
        id: categoryMap["id"],
        name: categoryMap["name"],
        category_image: categoryMap["category_image"],
       );
  }
}
