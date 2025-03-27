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
  List<GrocerySubCategoryModel> subCategoriesByCategory = [];
  List<GrocerySubCategoryModel> subCategoriesListForSelection = [];
  List<GroceryProductsModel> subCategoryProducts = [];
  bool isLoading = false;
  bool hasMorePages = true;
  int _currentPage = 1;
  get currentPage => _currentPage;
  set currentPage(value) {
    _currentPage = value;
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

  // Fetch Grocery Sub Category By Category List
  fetchGrocerySubCategoryByCategory(
    BuildContext context,
    int? categoryId,
  ) async {
    print('In========  ${currentPage}  =========>In');

    if (isLoading || !hasMorePages) {
      return; // Prevent multiple calls
    }
    isLoading = true;
    notifyListeners();

    SVProgressHUD.show();
    try {
      final response = await _groceryRepo.fetchGrocerySubCategoryByCategory(
          categoryId, currentPage);

      final totalPage = response['total_pages'];
      final responseData = response['results'];

      print('Total pages: $totalPage, Current Page: $currentPage');

      if (currentPage == 1) {
        subCategoriesByCategory = (responseData as List)
            .map((json) => GrocerySubCategoryModel.fromJson(json))
            .toList();
      } else {
        subCategoriesByCategory.addAll((responseData as List)
            .map((json) => GrocerySubCategoryModel.fromJson(json))
            .toList());
      }

      // Update pagination control
      hasMorePages = currentPage < totalPage;
      if (hasMorePages) currentPage++;

      notifyListeners();
    } catch (e) {
      print("Error fetching subcategories: $e");
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error_outline,
        message: 'Fetch Sub Category Failed',
      );
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
    }
  }

  // Fetch  Sub Category By Category For List  SubCategory in Product Add Edit Page
  fetchSubCategoryForSubCategorySelection(
    BuildContext context,
    int? categoryId,
  ) async {
    print('In========  ${currentPage}  =========>In');

    if (isLoading || !hasMorePages) {
      return; // Prevent multiple calls
    }
    isLoading = true;
    notifyListeners();

    SVProgressHUD.show();
    try {
      final response = await _groceryRepo.fetchGrocerySubCategoryByCategory(
          categoryId, currentPage);

      final totalPage = response['total_pages'];
      final responseData = response['results'];

      print('Total pages: $totalPage, Current Page: $currentPage');

      if (currentPage == 1) {
        subCategoriesListForSelection = (responseData as List)
            .map((json) => GrocerySubCategoryModel.fromJson(json))
            .toList();
      } else {
        subCategoriesListForSelection.addAll((responseData as List)
            .map((json) => GrocerySubCategoryModel.fromJson(json))
            .toList());
      }

      // Update pagination control
      hasMorePages = currentPage < totalPage;
      if (hasMorePages) currentPage++;

      notifyListeners();
    } catch (e) {
      print(e);
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error_outline,
        message: 'Fetch Sub Category Failed',
      );
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
      notifyListeners();
    }
  }

  // Add Sub Category

  addSubCategory(BuildContext context, data, categoryId) async {
    SVProgressHUD.show();
    try {
      final response = await _groceryRepo.addSubCategory(data);
      // add subcategory  to  List
      final newSubCategory = GrocerySubCategoryModel.fromJson(response);
      if (categoryId == response['category'])
        subCategoriesByCategory.add(newSubCategory);
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

      // Update the  Subcategories list
      final index1 =
          subCategoriesByCategory.indexWhere((sub) => sub.id == subCategoryId);
      if (index1 != -1) {
        if (subCategoriesByCategory[index1].category ==
            updatedSubCategory.category) {
          // Update only if category is the same
          subCategoriesByCategory[index1] = updatedSubCategory;
        } else {
          // Remove it if the category has changed
          subCategoriesByCategory.removeAt(index1);
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
      subCategoriesByCategory.removeWhere((sub) => sub.id == subCategoryId);

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

// -------------> Products Section

  // Fetch Grocery Products By Sub Category List
  fetchGroceryProductsBySubCategory(
    BuildContext context,
    int? subCategoryId,
  ) async {
    if (isLoading || !hasMorePages) {
      return; // Prevent multiple calls
    }
    isLoading = true;
    notifyListeners();
    SVProgressHUD.show();
    try {
      final response = await _groceryRepo.fetchProductsbySubcategory(
          subCategoryId, currentPage);
      final totalPage = response['total_pages'];

      final responseData = response['results'];
      if (currentPage == 1) {
        subCategoryProducts = (responseData as List)
            .map((json) => GroceryProductsModel.fromJson(json))
            .toList();
      } else {
        subCategoryProducts.addAll((responseData as List)
            .map((json) => GroceryProductsModel.fromJson(json))
            .toList());
      }
      // Update pagination control
      hasMorePages = currentPage < totalPage;
      if (hasMorePages) currentPage++;
      notifyListeners();
    } catch (e) {
      print(e);
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error_outline,
        message: 'Fetch Products Failed',
      );
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
      notifyListeners();
    }
  }

  // Add Product
  addProduct(BuildContext context, data, subCategoryId) async {
    SVProgressHUD.show();
    try {
      final response = await _groceryRepo.addProduct(data);
// Add Product to List
      print(response);
      final newProduct = GroceryProductsModel.fromJson(response);
      if (subCategoryId == response['sub_category']) {
        subCategoryProducts.add(newProduct);
      }
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
      final responseData = response['data'];
      // update the Product from List
      final updatedData = GroceryProductsModel.fromJson(responseData);
      final index =
          subCategoryProducts.indexWhere((product) => product.id == productId);
      if (subCategoryProducts[index].subCategory ==
          responseData['sub_category']) {
        subCategoryProducts[index] =
            updatedData; // Replace old entry with updated data
      } else {
        subCategoryProducts.removeAt(index);
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
