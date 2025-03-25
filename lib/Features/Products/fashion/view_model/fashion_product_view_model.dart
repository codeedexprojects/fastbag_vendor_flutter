import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/category_request_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../model/fashion_item_model.dart';
import '../repository/fashion_product_repository.dart';

class FashionProductViewModel extends ChangeNotifier {
  final FashionProductRepository _productRepository =
      FashionProductRepository();

  Results? fashionProductDetail;

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

  fetchFashionProductDetail(productId) async {
    try {
      SVProgressHUD.show();

      final response =
          await _productRepository.fetchFashionProductDetail(productId);
      fashionProductDetail = Results.fromJson(response);
    } catch (e) {
      print(e);
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  Future<void> addFashionProduct(
      {required BuildContext context,
      required data,
      required imageData}) async {
    try {
      SVProgressHUD.show();
      final response =
          await _productRepository.addFastionProduct(context, data);

      _fashionProducts.add(Results.fromJson((response)));

      print('response------------>$response');
      final productId = response['id'];
      print('--------------->$productId');
      updateImage(context, productId, imageData);
      notifyListeners();
      Navigator.pop(context);

      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Added Successfully');
    } catch (e) {
      showFlushbar(
          context: context,
          color: const Color(0xffFF5252),
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
      final index = fashionProducts.indexOf(
          fashionProducts.firstWhere((element) => element.id == productId));
      fashionProducts[index].isActive = response['is_active'];
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

  editProduct(
      {required context, required productId, required data, imageData}) async {
    try {
      final response = await _productRepository.editProduct(productId, data);
      final index = fashionProducts.indexOf(
          fashionProducts.firstWhere((element) => element.id == productId));
      if (fashionProducts[index].categoryId != response['categoryid'] ||
          fashionProducts[index].subcategoryId != response['subcategoryid']) {
        fashionProducts.removeAt(index);
      } else {
        fashionProducts[index] = Results.fromJson(response);
      }
      if (imageData != null) {
        updateImage(context, productId, imageData);
      }
      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Updated Successfully');

      print('response------------>$response');
    } catch (e) {
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Product Adding Failed');
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
// Delete Product Image

  deleteProductImage({
    required context,
    required int productId,
    required int imageId,
  }) async {
    try {
      SVProgressHUD.show();

      final response = await _productRepository.deleteProductImage(imageId);
      print('response------------>$response');

      final index = fashionProducts.indexOf(
          fashionProducts.firstWhere((element) => element.id == productId));

      fashionProducts[index]
          .images!
          .removeWhere((element) => element.id == imageId);
      notifyListeners();

      showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: 'Product Image Deleted Successfully');
    } catch (e) {
      print('error------------>$e');
      showFlushbar(
          context: context,
          color: Color(0xffFF5252),
          icon: Icons.error_outline,
          message: 'Product Image Delete Failed');
    } finally {
      SVProgressHUD.dismiss();
    }
  }
}
