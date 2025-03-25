import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_detail_class.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Commons/colors.dart';
import '../../../Commons/flush_bar.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<FoodResponseModel>?> getAllProducts(
      BuildContext context, subCatId) async {
    print("inside");

    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();

      final prefs = await SharedPreferences.getInstance();
      // var tokenId = prefs.getString('access_token');
      var vendorId = prefs.getInt('vendor_id');
      // Add the authorization header with the token

      // Perform the POST request
      Response response = await _dio.get(
        "${baseUrl}food/products/subcategory/$subCatId/vendor/$vendorId/",
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("products fetched successful: ${response.data}");

        SVProgressHUD.dismiss();
        List jsonList = response.data;
        List<FoodResponseModel> jsonData =
            jsonList.map((v) => FoodResponseModel.fromJson(v)).toList();
        return jsonData;
        // List<dynamic> res = response.data["results"];
        // return res;

        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(),
        // );
      }
    } on DioException catch (e) {
      print(e.response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> AddProductItem(
      BuildContext context, FoodItemModel model) async {
    print("inside");
    print("${baseUrl}food/dishes/");
    try {
      print("inside try");

      List<MultipartFile> imageFiles = [];

      for (String imagePath in model.image_urls) {
        // Assuming `sub_category_images` is a List<String>
        imageFiles.add(await MultipartFile.fromFile(
          imagePath,
          filename: basename(imagePath),
        ));
      }
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
        "images": imageFiles,
        "is_popular_product": model.is_popular_product,
        "is_offer_product": model.is_offer_product
      };

      print(data);
      FormData formData = FormData.fromMap(data);

      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);

      // Perform the POST request
      Response response = await _dio.post(
        "${baseUrl}food/dishes/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print(response.statusCode);

      // Handle the response
      if (response.statusCode == 201) {
        SVProgressHUD.dismiss();
        print("product added successful: ${response.data}");
        Navigator.pop(context);
        await showFlushbar(
            context: context,
            color: FbColors.buttonColor,
            message: "Product Added",
            icon: Icons.check);
        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(
        //     text: "Product Added",
        //     descrription:
        //         "Your product has been added to the list and is visible to customers",
        //     type: FbBottomDialogType.addSubCategory,
        //   ),
        // );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OOPs something happened")),
        );
        SVProgressHUD.dismiss();
        print("Bad data: ${response.data}");
      } else {
        SVProgressHUD.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OOPs something happened")),
        );
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened , Error: $e")),
      // );
      print("Error: $e");
    }
  }

  // Future<dynamic> deleteProduct(BuildContext context, int productId) async {
  //   print("inside");
  //   print("${baseUrl}food/dishes/$productId/");
  //   try {
  //     print("inside try");
  //     // Create FormData for file uploads
  //     SVProgressHUD.show();
  //
  //     String token = await StoreManager().getAccessToken() as String;
  //     // Add the authorization header with the token
  //     _dio.options.headers = {"Authorization": "Bearer $token"};
  //     print(token);
  //
  //     // Perform the POST request
  //     Response response = await _dio.delete(
  //       "${baseUrl}food/dishes/$productId/",
  //     );
  //     print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response}");
  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       SVProgressHUD.dismiss();
  //       print("product delete successful: ${response.data["results"]}");
  //       print("${response.data}");
  //       // List<dynamic> res = response.data["results"];
  //       showFlushbar(
  //           context: context,
  //           color: FbColors.buttonColor,
  //           icon: Icons.check,
  //           message: "product delete successful");
  //       Navigator.pop(context);
  //
  //       return response.data;
  //
  //     } else if (response.statusCode == 401) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text("OOPs something happened in products get")),
  //       );
  //
  //       SVProgressHUD.dismiss();
  //       print("Bad data: ${response.data}");
  //     } else {
  //       SVProgressHUD.dismiss();
  //       print("product deletion failed: ${response.data}");
  //     }
  //   } catch (e) {
  //     SVProgressHUD.dismiss();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text("OOPs something happened category get , Error: $e")),
  //     );
  //     print("Error: $e");
  //   }
  // }
  Future<dynamic> deleteProduct(BuildContext context, int productId) async {
    print("inside deleteProduct");
    print("Deleting: ${baseUrl}food/dishes/$productId/");

    try {
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      _dio.options.headers = {"Authorization": "Bearer $token"};

      Response response = await _dio.delete("${baseUrl}food/dishes/$productId/");
      SVProgressHUD.dismiss(); // Hide loading indicator

      print("Response: ${response.data}"); // Debugging

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("✅ Product deleted successfully!");

        // ✅ Remove invalid key access & print full response
        print("Response data: ${response.data}");

        showFlushbar(
          context: context,
          color: FbColors.buttonColor,
          icon: Icons.check,
          message: "Product deleted successfully!",
        );

        Future.delayed(Duration(seconds: 1), () {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });

        return response.data;
      } else {
        print("Product deletion failed. Status: ${response.statusCode}");
        print("Response data: ${response.data}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete product!")),
        );
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      print("Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting product: $e")),
      );
    }
  }


  Future<dynamic> EditProductItem(
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
        Navigator.pop(context);
        await showFlushbar(
            context: context,
            color: FbColors.buttonColor,
            message: "Product Updated",
            icon: Icons.check);
        // showDialog(
        //   context: context,
        //   barrierDismissible: true,
        //   builder: (BuildContext context) => const FbBottomDialog(
        //     text: "Product Edited",
        //     descrription: "Your product has been updated successfully",
        //     type: FbBottomDialogType.addSubCategory,
        //   ),
        // );
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

  Future<FoodDetail?> fetchfoodDetail(int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      print('toekn id $tokenId');
      var headers = {'Authorization': 'Bearer $tokenId'};
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}/food/dishes/$productId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        return FoodDetail.fromJson(response.data);
      }
    } on DioException catch (e) {
      print("error ${e.response}");
      print(e.response);
    }
  }
}
