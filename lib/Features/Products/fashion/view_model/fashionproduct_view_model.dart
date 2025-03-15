import 'package:flutter/material.dart';
import '../../food/Model/food_item_model.dart';
import '../model/fashion_item_model.dart';
import '../repository/fashion_product_repository.dart';

class FashionProductViewModel extends ChangeNotifier {
  final FashionProductRepository _productRepository =
      FashionProductRepository();

  // FashionItemModel? fashionItemModel;

  List<Results> _fashionProducts = [];

  List<Results> get fashionProducts => _fashionProducts;

  getFashionProductCategories({required int subCategoryId}) async {
    await _productRepository.fashiongetAllProducts(subCategoryId).then((v) {
      _fashionProducts = v?.results ?? [];
      notifyListeners();
    });
  }

  // Future<List<FashionItemModel>> getProductCategories({required BuildContext context,required int subCategoryId}) async {
  //   var res = await _productRepository.fashiongetAllProducts(context);
  //   if(res != null){
  //     _fashionProducts=
  //       res
  //   .where((data) => data["subcategory"] == subCategoryId) // Filter data first
  //   .map<FashionItemModel>((data) => FashionItemModel.fromMap(data)) // Convert to model
  //   .toList();
  //   print(_fashionProducts);
  //   notifyListeners();
  //   }
  //   return _fashionProducts;
  // }

  Future<void> addFoodItem(
      {required BuildContext context, required FoodItemModel model}) async {
    var res = await _productRepository.fashionAddProductItem(context, model);
    if (res != null) {
      print(res);
    }
  }

  Future<void> deleteFoodItem(
      {required BuildContext context, required int productId}) async {
    var res = await _productRepository.fashiondeleteProduct(context, productId);
    if (res != null) {
      print(res);
    }
  }

  Future<void> editFoodItem(
      {required BuildContext context, required FoodItemModel product}) async {
    var res = await _productRepository.fashionEditProductItem(context, product);
    if (res != null) {
      print(res);
    }
  }
}
