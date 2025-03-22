import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/category_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_categoryby_subcategory.dart';
import 'package:flutter/material.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../repository/fashion_category_repository.dart';

class FashionCategoryViewModel extends ChangeNotifier {
  FashionCategoryRepository _categoryRepository = FashionCategoryRepository();

  List<FashionCategoryModel> _categories = [];

  List<FashionCategoryModel> get categories => _categories;

  List<FashionSubCategoryModel> _subCategories = [];

  List<FashionSubCategoryModel> get subCategories => _subCategories;

  List<FashionSubCategoryModel> _selectsubCategory = [];

  List<FashionSubCategoryModel> get selectsubCategory => _selectsubCategory;

  getfashionProductCategories() async {
    await _categoryRepository.fashionproductCategoryGet().then((v) {
      _categories = v ?? [];
      notifyListeners();
    });
  }

  getFashionCategorybySubCategories({required int categoryId}) async {
    await _categoryRepository
        .fashionpCategorybySubCategoryGet(categoryId)
        .then((v) {
      _selectsubCategory = v ?? [];
      notifyListeners();
    });
  }

  getFashionProductSubCategories() async {
    await _categoryRepository.fashionproductSubCategoryGet().then((v) {
      _subCategories = v ?? [];
      notifyListeners();
    });
  }

  Future<void> addProductSubCategory(
      {required BuildContext context,
      required FashionSubCategoryModel subCategories}) async {
    await _categoryRepository.fashionProductSubCategoryPost(
        context, subCategories);
  }

  //
  Future<void> editProductSubCategory(
      {required BuildContext context,
      required FashionSubCategoryModel subCategories,
      required int subcategoryId}) async {
    await _categoryRepository.fashionProductSubCategoryEdit(
        context, subCategories, subcategoryId);
  }
}
