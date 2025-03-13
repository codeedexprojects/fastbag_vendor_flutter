import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

import '../model/fashion_sub_category_model.dart';

class FashionCategoryRepository {
  final Dio _dio = Dio();

  Future<dynamic> fashionproductCategoryGet(BuildContext context) async {
    // print("inside");
    // print("${baseUrl}vendors/categories/view/");
    // try {
    //   print("inside try");
    //   // Create FormData for file uploads
    //   SVProgressHUD.show();
    //
    //   String token = await StoreManager().getAccessToken() as String;
    //   // Add the authorization header with the token
    //   // _dio.options.headers = {"Authorization": "Bearer $token"};
    //   print(token);
    //
    //   String storeType = await StoreManager().getStoreType() as String;
    //
    //   // Perform the POST request
    //   Response response = await _dio.get(
    //     "${baseUrl}vendors/categories/filter/?store_type_name=Fashion",
    //   );
    //
    //   // Handle the response
    //   if (response.statusCode == 200) {
    //     SVProgressHUD.dismiss();
    //     print("category fetched successful: ${response.data}");
    //     List<dynamic> res = response.data;
    //     return res;
    //
    //     // showDialog(
    //     //   context: context,
    //     //   barrierDismissible: true, // Allow dismissing by tapping outside
    //     //   builder: (BuildContext context) => const FbBottomDialog(),
    //     // );
    //   } else if (response.statusCode == 401) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text("OOPs something happened in category get")),
    //     );
    //     SVProgressHUD.dismiss();
    //     print("Bad data: ${response.data}");
    //   } else {
    //     SVProgressHUD.dismiss();
    //     print("category fetching failed: ${response.data}");
    //   }
    // } on DioException catch (e) {
    //   SVProgressHUD.dismiss();
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(content: Text("OOPs something happened category get , Error: $e")),
    //   // );
    //   print("Error by category: ${e.response}}");
    // }
  }

  Future<dynamic> fashionproductSubCategoryGet(BuildContext context) async {
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

  Future<dynamic> fashionProductSubCategoryPost(
      BuildContext context, FashionSubCategoryModel model) async {
    print("inside");
    print("${baseUrl}food/subcategories/");
    try {
      print("inside try");

      FormData formData = FormData.fromMap({
        "category": model.categoryId,
        "enable_subcategory": model.is_enabled,
        "name": model.name,
        "subcategory_image": await MultipartFile.fromFile(
          model.sub_category_image,
          filename: basename(model.sub_category_image),
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
      BuildContext context, FashionSubCategoryModel model) async {
    print("inside");
    print("${baseUrl}food/subcategories/${model.id}/");
    try {
      print("inside try");

      FormData formData = FormData.fromMap({
        "enable_subcategory": model.is_enabled,
        "name": model.name,
        if (model.sub_category_image.isNotEmpty)
          "subcategory_image": await MultipartFile.fromFile(
            model.sub_category_image,
            filename: basename(model.sub_category_image),
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
    } catch (e) {
      SVProgressHUD.dismiss();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("OOPs something happened , Error: $e")),
      // );
      print("Error: $e");
    }
  }
}
