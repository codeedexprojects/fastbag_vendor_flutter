import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/product_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/repository/grocery_product_repository.dart';
import 'package:flutter/material.dart';

class GroceryProductViewModel extends ChangeNotifier {
  final GroceryProductRepository _repository = GroceryProductRepository();

  List<GroceryItemModel> _foodProducts = [];

  List<GroceryItemModel> get foodProducts => _foodProducts;

  Future<List<GroceryItemModel>> getProductCategories(
      {required BuildContext context, required int subCategoryId}) async {
    var res = await _repository.getGroceryProducts(context);
    if (res != null) {
      _foodProducts = res
          .where((data) =>
              data["subcategory"] == subCategoryId) // Filter data first
          .map<GroceryItemModel>(
              (data) => GroceryItemModel.fromJson(data)) // Convert to model
          .toList();
      print(_foodProducts);
      notifyListeners();
    }
    return _foodProducts;
  }

  Future<void> addFoodItem(
      {required BuildContext context, required GroceryItemModel model}) async {
    var res = await _repository.addGroceryProduct(context, model);
    if (res != null) {
      print(res);
    }
  }

  Future<void> deleteFoodItem(
      {required BuildContext context, required int productId}) async {
    var res = await _repository.deleteGroceryProduct(context, productId);
    if (res != null) {
      print(res);
    }
  }

  Future<void> editFoodItem(
      {required BuildContext context, required GroceryItemModel product}) async {
    var res = await _repository.editGroceryProduct(context, product);
    if (res != null) {
      print(res);
    }
  }
}
