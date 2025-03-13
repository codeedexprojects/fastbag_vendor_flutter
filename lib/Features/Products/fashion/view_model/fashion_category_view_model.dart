import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/category_repository.dart';
import 'package:flutter/material.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../repository/fashion_category_repository.dart';

class FashionCategoryViewModel extends ChangeNotifier {
  final FashionCategoryRepository _categoryRepository = FashionCategoryRepository();

  List<FashionCategoryModel> _categories = [
  ];
  List<FashionCategoryModel> get categories => _categories;

  List<FashionSubCategoryModel> _subCategories = [
  ];
  List<FashionSubCategoryModel> get subCategories => _subCategories;

  Future<List<FashionCategoryModel>> getProductCategories(
      {required BuildContext context}) async {
    var res = await _categoryRepository.fashionproductCategoryGet(context);
    if (res != null) {
      _categories = res
          .map<FashionCategoryModel>((data) => CategoryModel.fromMap(data))
          .toList();
      print(_categories);
      notifyListeners();
    }
    return _categories;
  }

  Future<List<FashionSubCategoryModel>> getProductSubCategories(
      {required BuildContext context}) async {
    var res = await _categoryRepository.fashionproductSubCategoryGet(context);
    if (res != null) {
      _subCategories = res
          .map<FashionSubCategoryModel>((data) => FashionSubCategoryModel.fromMap(data))
          .toList();
      print(_subCategories);
      notifyListeners();
    }
    print("returning subcategories $_subCategories");
    return _subCategories;
  }

  Future<void> addProductSubCategory(
      {required BuildContext context,
      required FashionSubCategoryModel subCategories}) async {
    await _categoryRepository.fashionProductSubCategoryPost(context, subCategories);
  }

  Future<void> editProductSubCategory(
      {required BuildContext context,
      required FashionSubCategoryModel subCategories}) async {
    await _categoryRepository.fashionProductSubCategoryEdit(context, subCategories);
  }
}
