import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_response.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<FoodResponseModel> _foodProducts = [];

  List<FoodResponseModel> get foodProducts => _foodProducts;

  // List<FoodResponseModel> foodresponse = [];

  Future  getProductCategories(
      {required BuildContext context, required int subCategoryId}) async {
    var res = await _productRepository.getAllProducts(context, subCategoryId);
    if (res != null) {
      _foodProducts = res;
      notifyListeners();
    }
  }

  Future<void> addFoodItem(
      {required BuildContext context, required FoodItemModel model}) async {
    var res = await _productRepository.AddProductItem(context, model);
    if (res != null) {
      print(res);
    }
  }

  Future<void> deleteFoodItem(
      {required BuildContext context, required int productId}) async {
    var res = await _productRepository.deleteProduct(context, productId);
    if (res != null) {
      print(res);
    }
  }

  Future<void> enableDisableProduct(int productId, bool isProductEnabled) async {
    SVProgressHUD.show();
    try {
      notifyListeners(); // Notify UI to show loading state
      var response = await _productRepository.enableDisableProduct(productId, isProductEnabled);
      print("Product Updated: $response");
      // Notify UI after updating the product
      notifyListeners();

    } catch (e) {
      notifyListeners();
      print("Error enabling/disabling product: $e");
    }
    SVProgressHUD.dismiss();
  }

   Future<void> editFoodItem(
      {required BuildContext context, required FoodItemModel product}) async {
    var res = await _productRepository.EditProductItem(context, product);
    if (res != null) {
      print(res);
    }
  }
}
