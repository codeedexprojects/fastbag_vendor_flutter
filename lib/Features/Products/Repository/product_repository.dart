import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<dynamic> getAllProducts(BuildContext context) async {
    print("inside");
    print("${baseUrl}food/dishes/");
    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);

      // Perform the POST request
      Response response = await _dio.get(
        "${baseUrl}food/dishes/",
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("products fetched successful: ${response.data["results"]}");
        List<dynamic> res = response.data["results"];
        return res;

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
        print("products fetching failed: ${response.data}");
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
      Map<String,dynamic> data={
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

  Future<dynamic> deleteProduct(BuildContext context,int productId) async {
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

  Future<dynamic> EditProductItem(BuildContext context, FoodItemModel model) async {
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

}
