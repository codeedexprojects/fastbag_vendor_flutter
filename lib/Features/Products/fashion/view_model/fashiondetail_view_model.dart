
import 'package:flutter/cupertino.dart';


import '../model/fashion_detail_class.dart';
import '../repository/fashion_product_repository.dart';

class FashiondetailViewModel extends ChangeNotifier{
  FashionProductRepository _getfashiondetail=FashionProductRepository();
  FashionDetail? foodDetail;

  getfashiondata(productId) async{
    await _getfashiondetail.fetchfashionDetail(productId).then((v){
      foodDetail=v;
      notifyListeners();
    });
  }
}