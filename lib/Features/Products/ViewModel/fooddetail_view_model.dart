import 'package:fastbag_vendor_flutter/Features/Products/Model/food_detail_class.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FoodViewModel extends ChangeNotifier{
  ProductRepository _getfooddetail=ProductRepository();
  FoodDetail? foodDetail;

  getfooddata(productId) async{
    await _getfooddetail.fetchfoodDetail(productId).then((v){
      foodDetail=v;
      notifyListeners();
    });
  }
}