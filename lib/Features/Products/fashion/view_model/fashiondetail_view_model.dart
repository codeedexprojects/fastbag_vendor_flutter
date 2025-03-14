
import 'package:flutter/cupertino.dart';


import '../model/fashion_detail_class.dart';
import '../repository/fashion_product_repository.dart';

class FashiondetailViewModel extends ChangeNotifier{
  FashionProductRepository _getfashiondetail=FashionProductRepository();
  FashionDetail? fashionDetail;

  getfashiondata(productId) async{
    await _getfashiondetail.fetchfashionDetail(productId).then((v){
      fashionDetail=v;
      notifyListeners();
    });
  }
}