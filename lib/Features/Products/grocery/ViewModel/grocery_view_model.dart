import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/Repository/grocery_repository.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_sub_categoryModel';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class GroceryViewModel extends ChangeNotifier {
  List<GroceryCategoryModel> categories = [];
  List<SubCategoryModel> subCategories = [];

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
      print(response);
      // Map JSON response to GroceryCategoryModel list
      subCategories = (response)
          .map((json) => GrocerySubCategoryModel.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  addProduct(BuildContext context, data) async {
    SVProgressHUD.show();
    try {
      await _groceryRepo.addProduct(data);
      showFlushbar(
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
}
