import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/addproduct_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/color_picker.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/add_fashion_product.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view_model/fashion_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:provider/provider.dart';

import '../model/fashion_item_model.dart';
import '../repository/fashion_product_repository.dart';

class FashionProductViewModel extends ChangeNotifier {
  final FashionProductRepository _productRepository =
      FashionProductRepository();

  // FashionItemModel? fashionItemModel;

  List<Results> _fashionProducts = [];

  List<Results> get fashionProducts => _fashionProducts;

  CategoryRequestModel? categoryRequestModel;

  getFashionProductCategories({required int subCategoryId}) async {
    await _productRepository.fashiongetAllProducts(subCategoryId).then((v) {
      _fashionProducts = v?.results ?? [];
      notifyListeners();
    });
  }

  ColorPickerModel? colorPicker;

  Future<void> addFashionProduct(
      {required BuildContext context,
      required data,
      required imageData}) async {
    try {
      SVProgressHUD.show();

      final response = await _productRepository.addFastionProduct(
        context,
        data,
      );

      _fashionProducts.add(Results.fromJson((response)));

      print('response------------>$response');
      final productId = response['id'];
      print('--------------->$productId');
      updateImage(context, productId, imageData);
      notifyListeners();

      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Added Successfully');
    } catch (e) {
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Product Adding Failed');
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  updateImage(context, productId, data) async {
    try {
      final response = await _productRepository.updateImage(productId, data);
      final index = fashionProducts.indexOf(
          fashionProducts.firstWhere((element) => element.id == productId));

      fashionProducts[index] = Results.fromJson(response);
      notifyListeners();

      print('response------------>$response');
    } catch (e) {
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Image Adding Failed');
    }
  }

  enableDisdableProduct(
      {required context,
      required int productId,
      required bool isActive}) async {
    try {
      SVProgressHUD.show();

      final response =
          await _productRepository.enableDisableProduct(productId, isActive);
      print('response------------>$response');
      showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Status Updated');
      notifyListeners();
    } catch (e) {
      print('error------------>$e');
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Product Status Failed');
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  deleteProduct({
    required context,
    required int productId,
  }) async {
    try {
      SVProgressHUD.show();

      final response = await _productRepository.deleteProduct(productId);
      print('response------------>$response');

      fashionProducts.removeWhere((element) => element.id == productId);
      notifyListeners();

      showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Deleted Successfully');
    } catch (e) {
      print('error------------>$e');
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Product Delete Failed');
    } finally {
      SVProgressHUD.dismiss();
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
