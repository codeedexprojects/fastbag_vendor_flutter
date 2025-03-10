import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<FoodItemModel> _foodProducts = [];
  List<FoodItemModel> get foodProducts => _foodProducts;

  Future<List<FoodItemModel>> getProductCategories({required BuildContext context,required int subCategoryId}) async {
    var res = await _productRepository.getAllProducts(context);
    if(res != null){
      _foodProducts =
        res
    .where((data) => data["subcategory"] == subCategoryId) // Filter data first
    .map<FoodItemModel>((data) => FoodItemModel.fromMap(data)) // Convert to model
    .toList();
    print(_foodProducts);
    notifyListeners();
    }
    return _foodProducts;
  }

  Future<void> addFoodItem({required BuildContext context,required FoodItemModel model}) async {
    var res = await _productRepository.AddProductItem(context,model);
    if(res != null){
    print(res);
    }
    
  }

  Future<void> deleteFoodItem({required BuildContext context,required int productId}) async {
    var res = await _productRepository.deleteProduct(context,productId);
    if(res != null){
    print(res);
    }
    
  }

  Future<void> editFoodItem({required BuildContext context,required FoodItemModel product}) async {
    var res = await _productRepository.EditProductItem(context,product);
    if(res != null){
    print(res);
    }
    
  }

  
}
