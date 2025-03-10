import 'package:fastbag_vendor_flutter/Features/Dashboard/model/dish_class.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/repository/dash_repository.dart';
import 'package:flutter/material.dart';

class DashViewModel extends ChangeNotifier{
  DashRepository _getdish=DashRepository();
  DishClass? dishClass;

  getdata() async {
    await _getdish.fetchDishCount().then((v) {
      dishClass = v;
      notifyListeners();
    });
  }
}