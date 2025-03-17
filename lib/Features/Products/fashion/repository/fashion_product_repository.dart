import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_detail_class.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_detail_class.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_item_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/view/add_fashion_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/addproduct_model.dart';
import '../view_model/fashiondetail_view_model.dart';

class FashionProductRepository {
  final Dio _dio = Dio();


  Future<FashionItemModel?> fashiongetAllProducts( int subcategoryId) async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      // var tokenId = prefs.getString('access_token');
      var vendorId = prefs.getInt('vendor_id');

      // var headers = {'Authorization': 'Bearer $tokenId'};

      var response = await _dio.request(
        '${baseUrl}fashion/products/subcategory/$subcategoryId/vendor/$vendorId/',
            // 'fashion/clothing/?category=$categoryId&subcategory=$subcategoryId&vendor=$vendorId',
        options: Options(method: 'GET',
            // headers: headers
        ),
      );

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
  // Future<FashionItemModel?> fashiongetAllProducts(int subcategoryId) async {
  //   // print("inside");
  //   // print("${baseUrl}food/dishes/");
  //   // try {
  //   //   print("inside try");
  //   //   // Create FormData for file uploads
  //   //   SVProgressHUD.show();
  //   //
  //   //   String token = await StoreManager().getAccessToken() as String;
  //   //   // Add the authorization header with the token
  //   //   _dio.options.headers = {"Authorization": "Bearer $token"};
  //   //   print(token);
  //   //
  //   //   // Perform the POST request
  //   //   Response response = await _dio.get(
  //   //     "${baseUrl}food/dishes/",
  //   //   );
  //   //
  //   //   // Handle the response
  //   //   if (response.statusCode == 200) {
  //   //     SVProgressHUD.dismiss();
  //   //     print("products fetched successful: ${response.data["results"]}");
  //   //     List<dynamic> res = response.data["results"];
  //   //     return res;
  //   //
  //   //     // showDialog(
  //   //     //   context: context,
  //   //     //   barrierDismissible: true, // Allow dismissing by tapping outside
  //   //     //   builder: (BuildContext context) => const FbBottomDialog(),
  //   //     // );
  //   //   } else if (response.statusCode == 401) {
  //   //     ScaffoldMessenger.of(context).showSnackBar(
  //   //       const SnackBar(
  //   //           content: Text("OOPs something happened in products get")),
  //   //     );
  //   //     SVProgressHUD.dismiss();
  //   //     print("Bad data: ${response.data}");
  //   //   } else {
  //   //     SVProgressHUD.dismiss();
  //   //     print("products fetching failed: ${response.data}");
  //   //   }
  //   // } catch (e) {
  //   //   SVProgressHUD.dismiss();
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(
  //   //         content: Text("OOPs something happened category get , Error: $e")),
  //   //   );
  //   //   print("Error: $e");
  //   // }
  //   try{
  //     SVProgressHUD.show();
  //   final prefs= await SharedPreferences.getInstance();
  //   var tokenId=prefs.getString('access_token');
  //   var headers = {
  //     'Authorization': 'Bearer $tokenId'
  //   };
  //
  //   var response = await _dio.request(
  //     '${baseUrl}fashion/clothing/?subcategory=$subcategoryId',
  //     options: Options(
  //       method: 'GET',
  //       headers: headers,
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print(response.data);
  //     SVProgressHUD.dismiss();
  //     return FashionItemModel.fromJson(response.data);
  //   }
  //   else {
  //     print(response.statusMessage);
  //   }}on DioException catch (e) {
  //
  //     print("error ${e.response?.data}");
  //   }
  // }



  Future<dynamic> fashiondeleteProduct(BuildContext context,int productId) async {
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

  Future<dynamic> fashionEditProductItem(BuildContext context, FoodItemModel model) async {
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
  Future<FashionDetail?>fetchfashionDetail(int productId)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      var headers = {
        'Authorization': 'Bearer $tokenId'
      };
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
        return FashionDetail.fromJson(response.data);
      }

    }on DioException catch (e) {
      print("error $e");
    }
  }
  Future<dynamic>addFastionProduct(BuildContext context,AddFashionProductModel model)async {
    try {
      SVProgressHUD.show();
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      var headers = {
        'Authorization': 'Bearer $tokenId'
      };
      Map<String, dynamic> data = {
        "vendor": model.vendor,
        "category_id": model.categoryId,
        "subcategory_id": model.subcategoryId,
        "name": model.name,
        "description": model.description,
        "gender": model.gender,
        "discount": model.discount,
        "colors": model.colors,
        "material": model.material,
        "is_active": model.isActive,

      };
      var response = await dio.request(
        '${baseUrl}fashion/clothing/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("product added successful: ${response.data}");
        showDialog(
          context: context,
          barrierDismissible: true, // Allow dismissing by tapping outside
          builder: (BuildContext context) => const FbBottomDialog(
            text: "Product Added",
            descrription:
            "Your product has been added to the list and is visible to customers",
            type: FbBottomDialogType.addSubCategory,
          ),
        );
      }
      else if (response.statusCode == 401) {
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
}
