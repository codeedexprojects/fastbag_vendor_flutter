import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/Model/register_model.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/approval_waiting_screen.dart';
import 'package:fastbag_vendor_flutter/Features/Authentication/View/verify_otp_screen.dart';
import 'package:fastbag_vendor_flutter/Features/BottomNavigation/CommonWidgets/fb_bottom_dialog.dart';
import 'package:fastbag_vendor_flutter/Features/Splash/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<dynamic> getStoreCategories(BuildContext context) async {
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/store-list/?format=json';
    print('Requesting URL: $url');

    try {
      // Simplified GET request
      var response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        return response.data
            .map<CategoryModel>((data) => CategoryModel.fromMap(data))
            .toList();
      } else {
        print("Error: ${response.statusMessage}");
      }
    } on DioException catch (dioError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "OOPs something happened , check your connection or try again later")),
      );
      print("DioException occurred: ${dioError.type}");
      print("DioException message: ${dioError.message}");
      if (dioError.response != null) {
        print("DioException data: ${dioError.response?.data}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error")),
      );
      print("Unexpected error: $e");
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  Future<void> registerVendor(RegisterModel model, BuildContext context) async {
    print("inside");
    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();
      FormData formData = FormData.fromMap({
        "owner_name": model.owner_name,
        "email": model.email,
        "business_name": model.business_name,
        "contact_number": model.contact_number,
        "address": model.address,
        "city": model.city,
        "state": model.state,
        "pincode": model.pincode,
        "store_logo": await MultipartFile.fromFile(
          model.store_logo.path,
          filename: basename(model.store_logo.path),
        ),
        "store_description": model.store_description,
        "store_type": model.store_type == "Restaurent" ? 1 : 2,
        "closing_time": model.closing_time,
        "opening_time": model.opening_time,
        "fssai_no": model.fssai_no,
        "fssai_certicate": await MultipartFile.fromFile(
          model.fssai_certicate.path,
          filename: basename(model.fssai_certicate.path),
        ),
        "bussiness_location": model.bussiness_location,
        "business_landmark": model.business_landmark,
        "alternate_email": model.alternate_email,
        "since": model.since,
        "display_image": await MultipartFile.fromFile(
          model.display_image.path,
          filename: basename(model.display_image.path),
        ),
        "is_Grocery": model.is_Grocery,
        "is_restaurent": true //model.is_restaurent,
      });

      // Perform the POST request
      Response response = await _dio.post(
        "${baseUrl}vendors/vendors/", // Replace with your API endpoint
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
        print("Registration successful: ${response.data}");
        await StoreManager().saveVendorId(response.data["id"]);
        navigate(
            context: context,
            screen: ApprovalWaitingScreen(
              id: response.data["id"],
            ));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OOPs something happened")),
        );
        SVProgressHUD.dismiss();
        print("Bad data: ${response.data}");
      } else {
        SVProgressHUD.dismiss();
        print("Registration failed: ${response.data}");
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OOPs something happened , Error: $e")),
      );
      print("Error: $e");
    }
  }

  Future<bool> checkAdminApproval(int id, BuildContext context) async {
    final url = '${baseUrl}vendors/vendor/approval-status/$id/';
    print('Requesting URL: $url');

    try {
      var response = await _dio.get(
        url,
        data: {"is_approved": true},
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        await StoreManager().saveApprovalStatus(response.data["is_approved"]);
        return response.data["is_approved"];
      } else if (response.statusCode == 401) {
        print("Error: ${response.data}");
        return false;
      }
    } on DioException catch (dioError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "OOPs something happened , check your connection or try again later")),
      );
      print("DioException occurred: ${dioError.type}");
      print("DioException message: ${dioError.message}");
      if (dioError.response != null) {
        print("DioException data: ${dioError.response?.data}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error")),
      );
      print("Unexpected error: $e");
    }
    return false;
  }

  Future<void> loginVendor(
      String email, String password, BuildContext context) async {
    final url = '${baseUrl}vendors/vendor/login/';
    print("final url $url");
    SVProgressHUD.show();
    try {
      FormData formData = FormData.fromMap({
        "email": email,
      });

      // Perform the POST request
      Response response = await _dio.post(
        url, // Replace with your API endpoint
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        SVProgressHUD.dismiss();
        print("Response received successfully!");
        print(response.data);
        if (response.data["message"] == "OTP sent to email") {
          navigate(
              context: context,
              screen: VerifyOtpScreen(
                email: email,
                password: password,
              ));
        }
        // return response.data
        //     .map<CategoryModel>((data) => CategoryModel.fromMap(data))
        //     .toList();
      }
    } on DioException catch (dioError) {
      SVProgressHUD.dismiss();
      if (dioError.response != null &&
          dioError.response?.data.error == "Vendor not found") {
        showDialog(
            context: context,
            builder: (context) {
              return const FbBottomDialog(
                  text: "text",
                  descrription: "descrription",
                  type: FbBottomDialogType.editSubCategoryNotPossible);
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "OOPs something happened , check your connection or try again later")),
        );
        print("DioException occurred: ${dioError.type}");
        print("DioException message: ${dioError.message}");
        if (dioError.response != null) {
          print("DioException data: ${dioError.response?.data}");
        }
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error")),
      );
      print("Unexpected error: $e");
    }
  }
}
