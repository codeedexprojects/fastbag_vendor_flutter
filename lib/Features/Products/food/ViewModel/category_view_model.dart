import 'package:fastbag_vendor_flutter/Features/Products/food/Model/category_model.dart';
import 'package:flutter/material.dart';

import '../Model/sub_category_model.dart';
import '../Repository/category_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<CategoryModel> _categories = [
  ];
  List<CategoryModel> get categories => _categories;

  List<SubCategoryModel> _subCategories = [
  ];
  List<SubCategoryModel> get subCategories => _subCategories;

  Future<List<CategoryModel>> getProductCategories(
      {required BuildContext context}) async {
    var res = await _categoryRepository.ProductCategoryGet(context);
    if (res != null) {
      _categories = res
          .map<CategoryModel>((data) => CategoryModel.fromMap(data))
          .toList();
      print(_categories);
      notifyListeners();
    }
    return _categories;
  }

  Future<List<SubCategoryModel>> getProductSubCategories(
      {required BuildContext context}) async {
    var res = await _categoryRepository.ProductSubCategoryGet(context);
    if (res != null) {
      _subCategories = res
          .map<SubCategoryModel>((data) => SubCategoryModel.fromMap(data))
          .toList();
      print(_subCategories);
      notifyListeners();
    }
    print("returning subcategories $_subCategories");
    return _subCategories;
  }

  Future<void> addProductSubCategory(
      {required BuildContext context,
      required SubCategoryModel subCategories}) async {
    await _categoryRepository.ProductSubCategoryPost(context, subCategories);
  }

  Future<void> editProductSubCategory(
      {required BuildContext context,
      required SubCategoryModel subCategories}) async {
    await _categoryRepository.ProductSubCategoryEdit(context, subCategories);
  }
}
