import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_category_model.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
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

  // Future<dynamic> fashionProductSubCategoryPost(
  //     BuildContext context, FashionSubCategoryModel model) async {
  //   print("inside");
  //   print("${baseUrl}food/subcategories/");
  //   try {
  //     print("inside try");
  //
  //     FormData formData = FormData.fromMap({
  //       "category": model.categoryId,
  //       "enable_subcategory": model.is_enabled,
  //       "name": model.name,
  //       "subcategory_image": await MultipartFile.fromFile(
  //         model.sub_category_image,
  //         filename: basename(model.sub_category_image),
  //       ),
  //       "vendor": model.vendor
  //     });
  //
  //     // Create FormData for file uploads
  //     SVProgressHUD.show();
  //
  //     String token = await StoreManager().getAccessToken() as String;
  //     // Add the authorization header with the token
  //     _dio.options.headers = {"Authorization": "Bearer $token"};
  //     print(token);
  //
  //     // Perform the POST request
  //     Response response = await _dio.post(
  //       "${baseUrl}food/subcategories/",
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );
  //
  //     print(response.statusCode);
  //
  //     // Handle the response
  //     if (response.statusCode == 201) {
  //       SVProgressHUD.dismiss();
  //       print("sub category added successful: ${response.data}");
  //       showDialog(
  //         context: context,
  //         barrierDismissible: true, // Allow dismissing by tapping outside
  //         builder: (BuildContext context) => const FbBottomDialog(
  //           text: "Sub Category Added",
  //           descrription:
  //               "Your Category has been added to the list and is visible to customers",
  //           type: FbBottomDialogType.addSubCategory,
  //         ),
  //       );
  //     } else if (response.statusCode == 401) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("OOPs something happened")),
  //       );
  //       SVProgressHUD.dismiss();
  //       print("Bad data: ${response.data}");
  //     } else {
  //       SVProgressHUD.dismiss();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("OOPs something happened")),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     print(e.response?.data);
  //     SVProgressHUD.dismiss();
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text("OOPs something happened , Error: $e")),
  //     // );
  //     print("Error: $e");
  //   }
  // }

  // Future<dynamic> fashionProductSubCategoryEdit(
  //     BuildContext context, FashionSubCategoryModel model) async {
  //   print("inside");
  //   print("${baseUrl}food/subcategories/${model.id}/");
  //   try {
  //     print("inside try");
  //
  //     FormData formData = FormData.fromMap({
  //       "enable_subcategory": model.is_enabled,
  //       "name": model.name,
  //       if (model.sub_category_image.isNotEmpty)
  //         "subcategory_image": await MultipartFile.fromFile(
  //           model.sub_category_image,
  //           filename: basename(model.sub_category_image),
  //         ),
  //     });
  //
  //     // Create FormData for file uploads
  //     SVProgressHUD.show();
  //
  //     String token = await StoreManager().getAccessToken() as String;
  //     // Add the authorization header with the token
  //     _dio.options.headers = {"Authorization": "Bearer $token"};
  //     print(token);
  //
  //     // Perform the POST request
  //     Response response = await _dio.patch(
  //       "${baseUrl}food/subcategories/${model.id}/",
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );
  //
  //     print(response.statusCode);
  //
  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       SVProgressHUD.dismiss();
  //       print("sub category updated successful: ${response.data}");
  //       showDialog(
  //         context: context,
  //         barrierDismissible: true, // Allow dismissing by tapping outside
  //         builder: (BuildContext context) => const FbBottomDialog(
  //           text: "Sub Category Updated",
  //           descrription:
  //               "Your Category has been updated to the list and is visible to customers",
  //           type: FbBottomDialogType.editSubCategory,
  //         ),
  //       );
  //     } else if (response.statusCode == 401) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("OOPs something happened")),
  //       );
  //       SVProgressHUD.dismiss();
  //       print("Bad data: ${response.data}");
  //     } else {
  //       SVProgressHUD.dismiss();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("OOPs something happened")),
  //       );
  //     }
  //   } catch (e) {
  //     SVProgressHUD.dismiss();
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text("OOPs something happened , Error: $e")),
  //     // );
  //     print("Error: $e");
  //   }
  // }
}
