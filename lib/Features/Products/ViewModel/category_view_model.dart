import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_categoryby_subCategory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  FoodSubCategoryModel? _categoryModel;

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

  deleteSubCategory({
    required BuildContext context,
    required int subcategoryId,
  }) async {
    await _categoryRepository.FoodCategoryBySubcategorydelete(
        context, subcategoryId);
  }

  int currentpage = 1;
  int allsubcategorypage = 1;
  bool gettingallsubcategory = false;
  bool subcategoryloadingall = false;

  getFoodCategorybySubCategories({required int categoryId}) async {
    print("mmmmmmmmmmmmmmmmmmmmmm ${_categoryModel?.totalPages}");
    subcategoryloadingall = true;

    await _categoryRepository.FoodCategoryBySubcategoryGet(
            categoryId: categoryId, page: allsubcategorypage)
        .then((v) {
      _categoryModel = v;
      _selectsubCategories = v?.results ?? [];
      v?.results != null
          ? subcategoryloadingall = false
          : subcategoryloadingall = false;
    });
    notifyListeners();
  }

  getAllSubCategoryLoading({required int categoryId}) async {
    print("paehges ${allsubcategorypage}");
    print("mmmmmmmmmmmmmmmmmmmmmm ${_categoryModel?.totalPages}");
    print(
        "knnscddwndbiownd ${allsubcategorypage == _categoryModel?.totalPages}");
    if (allsubcategorypage == _categoryModel?.totalPages) {
      return;
    }

    gettingallsubcategory = true;
    notifyListeners();
    allsubcategorypage++;
    await _categoryRepository.FoodCategoryBySubcategoryGet(
            categoryId: categoryId, page: allsubcategorypage)
        .then((value) {
      _categoryModel = value;
      if (value?.results != null) {
        _selectsubCategories.addAll(value?.results ?? []);
      } else if (value?.results == null) {
        gettingallsubcategory = false;
      }
    });
    notifyListeners();
  }
}
