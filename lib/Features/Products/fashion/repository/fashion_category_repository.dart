import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:fastbag_vendor_flutter/storage/fb_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/fashion_sub_category_model.dart';

class FashionCategoryRepository {
  final Dio _dio = Dio();

  Future<List<FashionCategoryModel>?> fashionproductCategoryGet() async {
    try{
      SVProgressHUD.show();
    var response = await _dio.request(
      '${baseUrl}vendors/categories/filter/?store_type_name=fashion',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List jsonList = response.data;
      List<FashionCategoryModel> jsonResponse =
          jsonList.map((v) => FashionCategoryModel.fromJson(v)).toList();
      print(json.encode(response.data));
      SVProgressHUD.dismiss();
      return jsonResponse;
    } }on DioException catch (e) {

      print("error $e");
    }
  }

  Future<List<FashionSubCategoryModel>?> fashionproductSubCategoryGet() async {

    try{
      SVProgressHUD.show();
    final prefs=await SharedPreferences.getInstance();
    var tokenId=prefs.getString('access_token');
    var headers = {
      'Authorization': 'Bearer $tokenId',
      "Content-Type": "application/json",
    };

    var response = await _dio.request(
      '${baseUrl}fashion/clothing-subcategories/',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      List jsonList=response.data;
      List<FashionSubCategoryModel> jsonResponce=
       jsonList.map((v)=>FashionSubCategoryModel.fromJson(v)).toList();
      print("jhhhhhhhhhhhhhhhhhhhhh    ${json.encode(response.data)}");
      SVProgressHUD.dismiss();
      return jsonResponce;
    }
    else {
      print(response.statusMessage);
    }}on DioException catch (e) {

      print("error ${e.response?.data}");
    }
  }

  Future<dynamic> fashionProductSubCategoryPost(
      BuildContext context, FashionSubCategoryModel model) async {
    try {
      print("inside try");
      final prefs = await SharedPreferences.getInstance();
      var vendorId = prefs.getInt(FbLocalStorage.vendorId);
      print(vendorId);
      FormData formData = FormData.fromMap({
        "category": model.category,
        "enable_subcategory": model.enableSubcategory,
        "name": model.name,
        "subcategory_image": await MultipartFile.fromFile(
          model.subcategoryImage.toString(),
          filename: basename(model.subcategoryImage.toString()),
        ),
        "vendor_id": vendorId,
        "description":model.description
      });

      // Create FormData for file uploads
      SVProgressHUD.show();


      var tokenId = prefs.getString('access_token');


      var headers = {'Authorization': 'Bearer $tokenId'};

      // Perform the POST request
      Response response = await _dio.post(
        "${baseUrl}fashion/clothing-subcategories/",
        data: formData,
        options: Options(
          headers: headers
        ),
      );

      print(response.statusCode);

      // Handle the response
      if (response.statusCode == 201) {
        SVProgressHUD.dismiss();
        print("sub category added successful: ${response.data}");
        showDialog(
          context: context,
          barrierDismissible: true, // Allow dismissing by tapping outside
          builder: (BuildContext context) => const FbBottomDialog(
            text: "Sub Category Added",
            descrription:
                "Your Category has been added to the list and is visible to customers",
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
    } on DioException catch (e) {
      print(e.response?.data);
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened , Error: $e")),
      // );
      print("Error: $e");
    }
  }

  Future<dynamic> fashionProductSubCategoryEdit(
      BuildContext context, FashionSubCategoryModel model,int subcategoryId) async {
    print("inside");

    try {
      print(subcategoryId);
      print("inside try");
      final prefs = await SharedPreferences.getInstance();
      var vendorId = prefs.getInt(FbLocalStorage.vendorId);
      FormData formData = FormData.fromMap({
        "category": model.category,
        "enable_subcategory": model.enableSubcategory,
        "name": model.name,
        "subcategory_image": await MultipartFile.fromFile(
          model.subcategoryImage.toString(),
          filename: basename(model.subcategoryImage.toString()),
        ),
        "vendor_id": vendorId,
        "description":model.description
      });
      // Create FormData for file uploads
      SVProgressHUD.show();

      var tokenId = prefs.getString('access_token');


      var headers = {'Authorization': 'Bearer $tokenId'};


      // Perform the POST request
      Response response = await _dio.patch(
        "${baseUrl}fashion/clothing-subcategories/$subcategoryId/",
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      print(response.statusCode);

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("sub category updated successful: ${response.data}");
        showDialog(
          context: context,
          barrierDismissible: true, // Allow dismissing by tapping outside
          builder: (BuildContext context) => const FbBottomDialog(
            text: "Sub Category Updated",
            descrription:
                "Your Category has been updated to the list and is visible to customers",
            type: FbBottomDialogType.editSubCategory,
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
    }  on DioException catch (e) {
      print(e.response?.data);
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened , Error: $e")),
      // );
      print("Error: $e");
    }
  }
}
