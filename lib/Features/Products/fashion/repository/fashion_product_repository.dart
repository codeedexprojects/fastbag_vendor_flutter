import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_detail_class.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FashionProductRepository {
  final Dio _dio = Dio();

  Future<FashionItemModel?> fashiongetAllProducts(int subcategoryId) async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      // var tokenId = prefs.getString('access_token');
      var vendorId = prefs.getInt('vendor_id');

      // var headers = {'Authorization': 'Bearer $tokenId'};

      var response = await _dio.request(
        '${baseUrl}fashion/products/subcategory/$subcategoryId/vendor/$vendorId/',
        // 'fashion/clothing/?category=$categoryId&subcategory=$subcategoryId&vendor=$vendorId',
        options: Options(
          method: 'GET',
          // headers: headers
        ),
      );

      print(
          '${baseUrl}fashion/products/subcategory/$subcategoryId/vendor/$vendorId/');

      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        return FashionItemModel.fromJson(response.data);
      } else {
        SVProgressHUD.dismiss();
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();
      print("Error ${e.response?.data}");
      return null;
    }
  }

  Future<dynamic> fashiondeleteProduct(
      BuildContext context, int productId) async {
    print("inside");
    print("${baseUrl}food/dishes/$productId/");
    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);

      // Perform the POST request
      Response response = await _dio.delete(
        "${baseUrl}food/dishes/$productId/",
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("product delete successful: ${response.data["results"]}");
        print(response.data);
        // List<dynamic> res = response.data["results"];
        return response.data;

        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(),
        // );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("OOPs something happened in products get")),
        );
        SVProgressHUD.dismiss();
        print("Bad data: ${response.data}");
      } else {
        SVProgressHUD.dismiss();
        print("product deletion failed: ${response.data}");
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("OOPs something happened category get , Error: $e")),
      );
      print("Error: $e");
    }
  }

  Future<dynamic> fashionEditProductItem(
      BuildContext context, FoodItemModel model) async {
    print("inside API call");
    print("${baseUrl}food/dishes/${model.id}/");

    try {
      print("inside try");

      List<MultipartFile> imageFiles = [];

      // Add only new images as files
      // if (newImages != null) {
      //   for (File file in model.image_urls) {
      //     imageFiles.add(await MultipartFile.fromFile(
      //       file.path,
      //       filename: basename(file.path),
      //     ));
      //   }
      // }

      Map<String, dynamic> data = {
        "vendor": model.vendor,
        "category": model.category,
        "subcategory": model.subcategory,
        "name": model.name,
        "description": model.description,
        "price": model.price,
        "offer_price": model.offer_price,
        "wholesale_price": model.wholesale_price,
        "variants": jsonEncode(model.variants),
        "discount": model.discount,
        "is_available": model.is_available,
        "is_popular_product": model.is_popular_product,
        "is_offer_product": model.is_offer_product,
        //"images": imageFiles, // Only new images as files
      };

      print(data);
      FormData formData = FormData.fromMap(data);
      print("Final FormData: ${formData.fields}");

      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      _dio.options.headers = {"Authorization": "Bearer $token"};

      print(token);

      Response response = await _dio.patch(
        "${baseUrl}food/dishes/${model.id}/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        SVProgressHUD.dismiss();
        print("Product edit successful: ${response.data}");
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => const FbBottomDialog(
            text: "Product Edited",
            descrription: "Your product has been updated successfully",
            type: FbBottomDialogType.addSubCategory,
          ),
        );
      } else {
        SVProgressHUD.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Oops! Something went wrong.")),
        );
        print("Bad data: ${response.data}");
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      print("Error: $e");
    }
  }

  Future<FashionDetail?> fetchfashionDetail(int productId) async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      var headers = {'Authorization': 'Bearer $tokenId'};
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}fashion/clothing/details/$productId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        SVProgressHUD.dismiss();
        return FashionDetail.fromJson(response.data);
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();
      print("error $e");
    }
  }

  Future<dynamic> addFastionProduct(BuildContext context, data) async {
    try {
      final tokenId = await StoreManager().getAccessToken();
      final vendorId = await StoreManager().getVendorId();
      var headers = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenId'
      };
      print("Printed  data on repov ---->  ${data}");

      Response response = await _dio.post(
        '${baseUrl}fashion/clothing/',
        options: Options(
          headers: headers,
        ),
        data: jsonEncode(data),
      );
      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Product adding failed';
    } catch (e) {
      print("erro $e");
    }
  }

  updateImage(productId, data) async {
    try {
      final tokenId = await StoreManager().getAccessToken();
      var headers = {
        "Content-Type": "multipart/form",
        'Authorization': 'Bearer $tokenId'
      };

      final formData = FormData.fromMap(data);

      Response response = await _dio.patch(
        '${baseUrl}fashion/clothing/details/$productId/',
        options: Options(
          headers: headers,
        ),
        data: formData,
      );
      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Image Updating failed';
    } catch (e) {
      print("erro $e");
    }
  }

  enableDisableProduct(productId, bool isActive) async {
    try {
      final tokenId = await StoreManager().getAccessToken();
      var headers = {'Authorization': 'Bearer $tokenId'};
      final data = {"is_active": isActive};

      final formData = FormData.fromMap(data);

      Response response = await _dio.patch(
        '${baseUrl}fashion/clothing/details/$productId/',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Product enable Disable failed';
    } catch (e) {
      print("erro $e");
    }
  }

  // edit product

  editProduct(productId, data) async {
    try {
      final tokenId = await StoreManager().getAccessToken();
      var headers = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenId'
      };
      Response response = await _dio.patch(
        '${baseUrl}fashion/clothing/details/$productId/',
        options: Options(
          headers: headers,
        ),
        data: jsonEncode(data),
      );

      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Product Unable to edit';
    } catch (e) {
      print("erro $e");
    }
  }

// delete peoduct
  deleteProduct(productId) async {
    try {
      final tokenId = await StoreManager().getAccessToken();
      var headers = {'Authorization': 'Bearer $tokenId'};

      Response response = await _dio.delete(
        '${baseUrl}fashion/clothing/details/$productId/',
        options: Options(
          headers: headers,
        ),
      );
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Product Unable to delete';
    } catch (e) {
      print("erro $e");
    }
  }

  // Delete Product Image

  deleteProductImage(imageId) async {
    try {
      final tokenId =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5MTQ2NjA4LCJpYXQiOjE3Mzc2MTA2MDgsImp0aSI6IjcyNWYyNzhhYmE5MjQyOTU5OTNhOWYzNmQ4M2VhNGE5IiwidXNlcl9pZCI6MX0.cQvNtygE7CC7Vvcsyxpzr3YdeiVSIbKMw4ZMZuGw9nQ';
      // await StoreManager().getAccessToken();
      var headers = {'Authorization': 'Bearer $tokenId'};

      Response response = await _dio.delete(
        '${baseUrl}fashion/clothing/images/${imageId}/delete/',
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (e) {
      print("Error: ${e.response}");
      final errorMessage = 'Unable to delete Image';
    } catch (e) {
      print("erro $e");
    }
  }
}
