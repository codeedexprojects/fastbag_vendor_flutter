import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/model/grocery_catgeory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

class GroceryRepository {
  final Dio _dio = Dio();

  Future<List<GroceryCategoryModel>?> groceryCategories(
      BuildContext context) async {
    try {
      SVProgressHUD.show();
      var dio = Dio();
      var response = await dio.request(
        'https://fastbag.pythonanywhere.com/vendors/categories/filter/?store_type_name=Grocery',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print("resposneeeeeeeeeeeeeeee ${response.data}");
        List jsonList = response.data;
        List<GroceryCategoryModel> groceryCategories = jsonList
            .map((json) => GroceryCategoryModel.fromJson(json))
            .toList();
        return groceryCategories;
      }
    } on DioException catch (e) {
      print("error ${e.response}");
    } catch (e) {}
  }

  // Future<dynamic> groceryCategories(BuildContext context) async {
  //   try {
  //     SVProgressHUD.show();
  //     String storeType = await StoreManager().getStoreType() as String;
  //
  //     // Perform the POST request
  //     Response response = await _dio.get(
  //       "${baseUrl}vendors/categories/filter/?store_type_name=$storeType",
  //     );
  //
  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       print("resposne ${response.data}");
  //       SVProgressHUD.dismiss();
  //       List<dynamic> res = response.data;
  //       return res;
  //     } else if (response.statusCode == 401) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text("OOPs something happened in category get")),
  //       );
  //       SVProgressHUD.dismiss();
  //       print("Bad data: ${response.data}");
  //     } else {
  //       SVProgressHUD.dismiss();
  //       print("category fetching failed: ${response.data}");
  //     }
  //   } on DioException catch (e) {
  //     SVProgressHUD.dismiss();
  //     print("Error fetching category: ${e.response?.data}");
  //     print("${e.response}");
  //   }
  // }

  Future<dynamic> grocerySubCategory(BuildContext context) async {
    try {
      // Create FormData for file uploads
      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};

      // Perform the POST request
      Response response = await _dio.get(
        "${baseUrl}grocery/gro-Subcategories/",
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("\n\nsub category fetched successful: ${response.data}");
        List<dynamic> res = response.data;
        return res;
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
      print("Error: $e");
    }
  }

  Future<dynamic> addGrocerySubCategory(
      BuildContext context, SubCategoryModel model) async {
    try {
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

      SVProgressHUD.show();

      String token = await StoreManager().getAccessToken() as String;
      _dio.options.headers = {"Authorization": "Bearer $token"};
      // Perform the POST request
      Response response = await _dio.post(
        "${baseUrl}grocery/gro-Subcategories/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      // Handle the response
      if (response.statusCode == 201) {
        SVProgressHUD.dismiss();
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
      } else {
        SVProgressHUD.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OOPs something happened")),
        );
      }
    } on DioException catch (e) {
      print(e.response?.data);
      SVProgressHUD.dismiss();
      print("Error: $e");
    }
  }

  Future<dynamic> editGrocerySubCategory(
      BuildContext context, SubCategoryModel model) async {
    try {
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

      // Perform the POST request
      Response response = await _dio.patch(
        "${baseUrl}grocery/gro-Subcategories/${model.id}/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
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
      } else {
        SVProgressHUD.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OOPs something happened")),
        );
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      print("Error: $e");
    }
  }
}
