import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/category_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_categoryby_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../repository/fashion_category_repository.dart';

class FashionCategoryViewModel extends ChangeNotifier {
  FashionCategoryRepository _categoryRepository = FashionCategoryRepository();
  FaSubCategoryModel? _subCategoryModel;

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

  deleteSubCategory({
    required BuildContext context,
    required int subcategoryId,
  }) async {
    await _categoryRepository.FashionSubCategoryDelete(context, subcategoryId);
  }

  int currentpage = 1;
  int allcategorypage = 1;
  bool gettingallproduct = false;
  bool productloadingall = false;

  getFashionCategorybySubCategories({required int categoryId}) async {
    productloadingall = true;
    await _categoryRepository
        .fashionpCategorybySubCategoryGet(
            categoryId: categoryId, page: allcategorypage)
        .then((v) {
      _selectsubCategory = v?.results ?? [];
      v?.results != null
          ? productloadingall = false
          : productloadingall = false;
    });
    notifyListeners();
  }

  getAllSubCategoryLoading({required int categoryId}) async {
    if (allcategorypage == _subCategoryModel?.totalPages) {
      return;
    }
    gettingallproduct = true;
    notifyListeners();
    allcategorypage++;
    await _categoryRepository
        .fashionpCategorybySubCategoryGet(
            categoryId: categoryId, page: allcategorypage)
        .then((value) {
      _subCategoryModel = value;
      if (value?.results != null) {
        _selectsubCategory.addAll(value?.results ?? []);
      } else if (value?.results == null) {
        gettingallproduct = false;
      }
    });
    notifyListeners();
  }
}
