import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/repository/grocery_category_repository.dart';
import 'package:flutter/material.dart';

import '../../food/Model/sub_category_model.dart';

class GroceryViewModel extends ChangeNotifier {
  final GroceryRepository _groceryRepository = GroceryRepository();

  List<GroceryCategoryModel> _categories = [];

  List<GroceryCategoryModel> get categories => _categories;

  List<SubCategoryModel> _subCategories = [];

  List<SubCategoryModel> get subCategories => _subCategories;

  Future getGroceryCategory(
      {required BuildContext context}) async {
    _categories  = await _groceryRepository.groceryCategories(context) ?? [];
    notifyListeners();
  }

  Future<List<SubCategoryModel>> getGrocerySubCategory(
      {required BuildContext context}) async {
    var res = await _groceryRepository.grocerySubCategory(context);
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

  Future<void> addGrocerySubCategory(
      {required BuildContext context,
      required SubCategoryModel subCategories}) async {
    await _groceryRepository.addGrocerySubCategory(context, subCategories);
  }

  Future<void> editGrocerySubCategory(
      {required BuildContext context,
      required SubCategoryModel subCategories}) async {
    await _groceryRepository.editGrocerySubCategory(context, subCategories);
  }
}
