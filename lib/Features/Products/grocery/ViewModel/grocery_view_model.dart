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
  List<GrocerySubCategoryModel> allSubCategories = [];
  List<GrocerySubCategoryModel> filteredSubCategories = [];

  List<GroceryProductsModel> subCategoryProducts = [];

  // Getter to return subcategories based on a selected category ID

  subCategoriesByCategory(int categoryId) {
    filteredSubCategories =
        allSubCategories.where((sub) => sub.category == categoryId).toList();
    notifyListeners();
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
        allSubCategories = response
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
      final response = await _groceryRepo.addSubCategory(data);
      // add subcategory  to  List
      final newSubCategory = GrocerySubCategoryModel.fromJson(response);
      allSubCategories.add(newSubCategory);
      notifyListeners();

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

  // Edit SubCategory
  editSubCategory(BuildContext context, int subCategoryId, data) async {
    SVProgressHUD.show();
    try {
      SVProgressHUD.show();
      final response = await _groceryRepo.editSubCategory(subCategoryId, data);

      // Convert response into model
      final updatedSubCategory = GrocerySubCategoryModel.fromJson(response);

      // Update the All Subcategories list
      final index =
          allSubCategories.indexWhere((sub) => sub.id == subCategoryId);
      if (index != -1) {
        allSubCategories[index] = updatedSubCategory;
      }

      // Update the Filtered Subcategories list
      final index1 =
          filteredSubCategories.indexWhere((sub) => sub.id == subCategoryId);
      if (index1 != -1) {
        if (filteredSubCategories[index1].category ==
            updatedSubCategory.category) {
          // Update only if category is the same
          filteredSubCategories[index1] = updatedSubCategory;
        } else {
          // Remove it if the category has changed
          filteredSubCategories.removeAt(index1);
        }
      }

      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Sub Category Updated Successfully');
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

// Delete Sub Category
  deleteSubCategory(BuildContext context, int subCategoryId) async {
    print(subCategoryId);

    SVProgressHUD.show();
    try {
      await _groceryRepo.deleteSubCategory(subCategoryId);

      // Remove the subcategory from List
      allSubCategories.removeWhere((sub) => sub.id == subCategoryId);
      filteredSubCategories.removeWhere((sub) => sub.id == subCategoryId);

      notifyListeners();
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.delete,
          message: 'Sub Category Deleted Successfully');
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
      final response = await _groceryRepo.addProduct(data);
// Add Product to List
      final newProduct = GroceryProductsModel.fromJson(response);
      subCategoryProducts.add(newProduct);
      notifyListeners();

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

  // Edit  Product
  editProduct(BuildContext context, int productId, data) async {
    try {
      SVProgressHUD.show();
      final response = await _groceryRepo.editProduct(productId, data);

      // update the Product from List
      final updatedData = GroceryProductsModel.fromJson(response['data']);

      final index =
          subCategoryProducts.indexWhere((product) => product.id == productId);
      if (index != -1) {
        subCategoryProducts[index] =
            updatedData; // Replace old entry with updated data
      }
      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Updated Successfully');
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

  // Enable Disable Product
  updateProductAvailable(
      BuildContext context, productId, isProductEnabled) async {
    SVProgressHUD.show();
    try {
      final response =
          await _groceryRepo.enableDisableProduct(productId, isProductEnabled);
      print(response['data']);
      final updatedData = GroceryProductsModel.fromJson(response['data']);
      // update the Product from List
      final index =
          subCategoryProducts.indexWhere((product) => product.id == productId);
      if (index != -1) {
        subCategoryProducts[index] =
            updatedData; // Replace old entry with updated data
      }
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

// Delete Sub Category
  deleteProducts(BuildContext context, int productId) async {
    print(productId);
    SVProgressHUD.show();
    try {
      await _groceryRepo.deleteProduct(productId);

      // Remove the Product from List
      subCategoryProducts.removeWhere((product) => product.id == productId);
      notifyListeners();
      showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.delete,
          message: 'Product Deleted Successfully');
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
