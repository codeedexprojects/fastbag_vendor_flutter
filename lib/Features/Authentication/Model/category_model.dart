class CategoryModel {
  final int id;
  final String name;
  final String description;

  CategoryModel(
      {required this.id, required this.name, required this.description});

  factory CategoryModel.fromMap(Map<String, dynamic> categoryMap) {
    return CategoryModel(
        id: categoryMap["id"],
        name: categoryMap["name"],
        description: categoryMap["description"]);
  }
}
