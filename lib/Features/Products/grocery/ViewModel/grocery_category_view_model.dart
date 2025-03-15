import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/Repository/grocery_category_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class GroceryCategoryViewModel extends ChangeNotifier {
  final GroceryCtegoryRepository _groceryRepository = GroceryCtegoryRepository();

  List<GroceryCategoryModel> categories = [];

  List<SubCategoryModel> subCategories = [];



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
