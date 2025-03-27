import 'dart:convert';

import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:fastbag_vendor_flutter/Commons/flush_bar.dart';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/food_categoryby_subCategory_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepository {
  final Dio _dio = Dio();

  Future<dynamic> ProductCategoryGet(BuildContext context) async {
    print("inside");
    print("${baseUrl}vendors/categories/view/");
    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();
      String storeType = await StoreManager().getStoreType() as String;

      // Perform the POST request
      Response response = await _dio.get(
        "${baseUrl}vendors/categories/filter/?store_type_name=$storeType",
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("category fetched successful: ${response.data}");
        List<dynamic> res = response.data;
        return res;

        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(),
        // );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("OOPs something happened in category get")),
        );
        SVProgressHUD.dismiss();
        print("Bad data: ${response.data}");
      } else {
        SVProgressHUD.dismiss();
        print("category fetching failed: ${response.data}");
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened category get , Error: $e")),
      // );
      print("Error: $e");
    }
  }

  Future<dynamic> ProductSubCategoryGet(BuildContext context) async {
    print("inside");
    print("${baseUrl}food/subcategories/");
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
        "${baseUrl}food/subcategories/view/",
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("\n\nsub category fetched successful: ${response.data}");
        List<dynamic> res = response.data;
        return res;

        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(),
        // );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("OOPs something happened in Sub category get")),
        );
        SVProgressHUD.dismiss();
        print("Bad data: ${response.data}");
      } else {
        SVProgressHUD.dismiss();
        print("sub category fetching failed: ${response.data}");
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened Sub category get , Error: $e")),
      // );
      print("Error: $e");
    }
  }

  Future<dynamic> ProductSubCategoryPost(
      BuildContext context, FoodCategoryBySubcategoryModel model) async {
    print("inside");
    print("${baseUrl}food/subcategories/");
    try {
      print("inside try");

      FormData formData = FormData.fromMap({
        "category": model.category,
        "enable_subcategory": model.enableSubcategory,
        "name": model.name,
        "subcategory_image": await MultipartFile.fromFile(
          model.subcategoryImage ?? "",
          filename: basename(model.subcategoryImage ?? ""),
        ),
        "vendor": model.vendor
      });

      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);

      // Perform the POST request
      Response response = await _dio.post(
        "${baseUrl}food/subcategories/",
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
        print("sub category added successful: ${response.data}");
        Navigator.pop(context);
        await showFlushbar(
            context: context,
            color: FbColors.buttonColor,
            message: "SubCategoryAdded",
            icon: Icons.check);
        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(
        //     text: "Sub Category Added",
        //     descrription:
        //         "Your Category has been added to the list and is visible to customers",
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
    } on DioException catch (e) {
      print(e.response?.data);
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened , Error: $e")),
      // );
      print("Error: $e");
    }
  }

  Future<dynamic> ProductSubCategoryEdit(
      BuildContext context, FoodCategoryBySubcategoryModel model) async {
    print("inside");
    print("${baseUrl}food/subcategories/${model.id}/");
    try {
      print("inside try");

      FormData formData = FormData.fromMap({
        "enable_subcategory": model.enableSubcategory,
        "name": model.name,
        if (model.subcategoryImage!.isNotEmpty)
          "subcategory_image": await MultipartFile.fromFile(
            model.subcategoryImage ?? '',
            filename: basename(model.subcategoryImage ?? ''),
          ),
      });

      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);

      // Perform the POST request
      Response response = await _dio.patch(
        "${baseUrl}food/subcategories/${model.id}/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print(response.statusCode);

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("sub category updated successful: ${response.data}");
        Navigator.pop(context);
        await showFlushbar(
            context: context,
            color: FbColors.buttonColor,
            message: "Sub Category Updated",
            icon: Icons.check);
        // showDialog(
        //   context: context,
        //   barrierDismissible: true, // Allow dismissing by tapping outside
        //   builder: (BuildContext context) => const FbBottomDialog(
        //     text: "Sub Category Updated",
        //     descrription:
        //         "Your Category has been updated to the list and is visible to customers",
        //     type: FbBottomDialogType.editSubCategory,
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

  Future<FoodSubCategoryModel?> FoodCategoryBySubcategoryGet({int? categoryId,int? page}) async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      // var tokenId = prefs.getString('access_token');
      var vendorId = prefs.getInt('vendor_id');
      print("hhhhh $vendorId");
      var headers = {
        'Authorization': 'Bearer $tokenId',
        "Content-Type": "application/json",
      };
      print("dhjhidih $categoryId");
      var response = await _dio.request(
        '${baseUrl}food/subcategories/by-category/$categoryId/?page=$page',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        // List jsonList = response.data;
        // List<FoodCategoryBySubcategoryModel> jsonResponce = jsonList
        //     .map((v) => FoodCategoryBySubcategoryModel.fromJson(v))
        //     .toList();
        // print("jhhhhhhhhhhhhhhhhhhhhh    ${json.encode(response.data)}");
        SVProgressHUD.dismiss();
        return FoodSubCategoryModel.fromJson(response.data);
        // // return jsonResponce;
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();
      print("error ${e.response?.data}");
    }
  }

  Future<dynamic> FoodCategoryBySubcategorydelete(
      BuildContext context, int subcategoryId) async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      var tokenId = prefs.getString('access_token');
      var vendorId = prefs.getInt('vendor_id');
      print("hhhhh $vendorId");
      var headers = {
        'Authorization': 'Bearer $tokenId',
        "Content-Type": "application/json",
      };
      print("dhjhidih $subcategoryId");
      var response = await _dio.request(
        '${baseUrl}food/subcategories/$subcategoryId/',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      if (response.statusCode == 204) {
        SVProgressHUD.dismiss();

        Navigator.pop(context);
        showFlushbar(
            context: context,
            color: FbColors.errorcolor,
            icon: Icons.delete,
            message: "subcategory delete successful");
        // List jsonList = response.data;
        // List<FoodCategoryBySubcategoryModel> jsonResponce = jsonList
        //     .map((v) => FoodCategoryBySubcategoryModel.fromJson(v))
        //     .toList();
        // print("jhhhhhhhhhhhhhhhhhhhhh    ${json.encode(response.data)}");
        // SVProgressHUD.dismiss();
        // return jsonResponce;
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();
      print("error ${e.response?.data}");
    }
  }
}
