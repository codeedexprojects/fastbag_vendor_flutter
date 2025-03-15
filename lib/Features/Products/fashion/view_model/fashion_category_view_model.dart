import 'package:flutter/material.dart';

import '../model/fashion_category_model.dart';
import '../model/fashion_sub_category_model.dart';
import '../repository/fashion_category_repository.dart';

class FashionCategoryViewModel extends ChangeNotifier {

  FashionCategoryRepository _categoryRepository = FashionCategoryRepository();

  List<FashionCategoryModel?> _categories = [
  ];
  List<FashionCategoryModel?> get categories => _categories;

  List<FashionSubCategoryModel> _subCategories = [
  ];
  List<FashionSubCategoryModel> get subCategories => _subCategories;

   getfashionProductCategories()async{
     await _categoryRepository.fashionproductCategoryGet().then((v) {
       _categories = v ??[];
       notifyListeners();
     });
  }

   getFashionProductSubCategories()async{
     await _categoryRepository.fashionproductSubCategoryGet().then((v){
     _subCategories=v??[];
     notifyListeners();
     });
   }


  // Future<void> addProductSubCategory(
  //     {required BuildContext context,
  //     required FashionSubCategoryModel subCategories}) async {
  //   await _categoryRepository.fashionProductSubCategoryPost(context, subCategories);
  // }
  //
  // Future<void> editProductSubCategory(
  //     {required BuildContext context,
  //     required FashionSubCategoryModel subCategories}) async {
  //   await _categoryRepository.fashionProductSubCategoryEdit(context, subCategories);
  // }
}
