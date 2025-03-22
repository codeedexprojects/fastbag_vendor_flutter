import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_categoryby_subCategory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  List<SubCategoryModel> _subCategories = [];

  List<SubCategoryModel> get subCategories => _subCategories;

  List<FoodCategoryBySubcategoryModel> _selectsubCategories = [];

  List<FoodCategoryBySubcategoryModel> get selectsubCategories =>
      _selectsubCategories;

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

  getFoodCategorybySubCategories({required int categoryId}) async {
    await _categoryRepository.FoodCategoryBySubcategoryGet(categoryId)
        .then((v) {
      _selectsubCategories = v ?? [];
      notifyListeners();
    });
  }

  Future<void> addProductSubCategory(
      {required BuildContext context,
      required FoodCategoryBySubcategoryModel subCategories}) async {
    await _categoryRepository.ProductSubCategoryPost(context, subCategories);
  }

  Future<void> editProductSubCategory(
      {required BuildContext context,
      required FoodCategoryBySubcategoryModel subCategories}) async {
    await _categoryRepository.ProductSubCategoryEdit(context, subCategories);
  }
}
