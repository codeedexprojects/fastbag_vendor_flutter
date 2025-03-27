import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

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

  // Edit Sub Category Of  Fashion
  Future<void> editFashionSubCategory(
      {required BuildContext context,
      required data,
      required int subcategoryId}) async {
    try {
      SVProgressHUD.show();
      final response = await _categoryRepository.editFashionSubCategory(
          context, data, subcategoryId);
      final index = selectsubCategory.indexOf(selectsubCategory
          .firstWhere((element) => element.id == subcategoryId));
      if (selectsubCategory[index].category != response['category']) {
        selectsubCategory.removeAt(index);
      } else
        selectsubCategory[index] = FashionSubCategoryModel.fromJson(response);

      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Sub Category Updated');
    } catch (e) {
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error_outline,
          message: 'Unable to Update');
    } finally {
      SVProgressHUD.dismiss();
    }
  }
}
