import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/Repository/grocery_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_products_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class GroceryViewModel extends ChangeNotifier {
  List<GroceryCategoryModel> categories = [];
  List<GrocerySubCategoryModel> subCategories = [];
  List<GroceryProductsModel> subCategoryProducts = [];

  // Getter to return subcategories based on a selected category ID

  List<GrocerySubCategoryModel> subCategoriesByCategory(int categoryId) {
    return subCategories.where((sub) => sub.category == categoryId).toList();
  }

  get filteredList => [];

  final _groceryRepo = GroceryRepository();

  Future fetchGroceryCategory(context) async {
    try {
      SVProgressHUD.show;
      final response = await _groceryRepo.fetchGroceryCategories();
      // Map JSON response to GroceryCategoryModel list
      categories = (response as List)
          .map((json) => GroceryCategoryModel.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error_outline,
          message: e.toString());
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  Future fetchGrocerySubCategory(context) async {
    try {
      SVProgressHUD.show();
      final response = await _groceryRepo.fetchGrocerySubCategory();
      //  Map JSON response to GroceryCategoryModel list
      if (response is List) {
        subCategories = response
            .map((json) =>
                GrocerySubCategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  // Fetch  Product List
  fetchProductList(BuildContext context, subCategoryId) async {
    try {
      final response = await _groceryRepo.fetchProducts(subCategoryId);

      subCategoryProducts = (response as List)
          .map((json) => GroceryProductsModel.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error_outline,
        message: 'Fetch Products Failed',
      );
    }
  }

  // Add Sub Category

  addSubCategory(
    BuildContext context,
    data,
  ) async {
    SVProgressHUD.show();
    try {
      await _groceryRepo.addSubCategory(data);
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Sub Category Added Successfully');
    } catch (e) {
      print(e);
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error_outline,
          message: e.toString());
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  // Add Product
  addProduct(
    BuildContext context,
    data,
  ) async {
    SVProgressHUD.show();
    try {
      await _groceryRepo.addProduct(data);
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Added Successfully');
    } catch (e) {
      print(e);
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error_outline,
          message: e.toString());
    } finally {
      SVProgressHUD.dismiss();
    }
  }
}
