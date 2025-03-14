import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/navigation_helper.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/update_shop_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/Model/vendor_model.dart';
import 'package:fastbag_vendor_flutter/Features/Profile/View/update_waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

class ProfileRepository {
  final Dio _dio = Dio();

  Future<dynamic> getProfile( BuildContext context) async {
    SVProgressHUD.show();
    String vendorId=StoreManager().getVendorId() as String;

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
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
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postSettings(
      int id, BuildContext context, Map<String, dynamic> settingsMap) async {
    print(settingsMap);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$id/';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: jsonEncode(settingsMap),
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
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postShopLogo(
      int id, BuildContext context, File logoFile) async {
    print(logoFile.path);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$id/';
    print('Requesting URL: $url');

    FormData formData = FormData.fromMap({
      "store_logo": await MultipartFile.fromFile(
        logoFile.path,
        filename: basename(logoFile.path),
      ),
    });

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postShopDescriptiom(
      int id, BuildContext context, String description) async {
    print(description);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$id/';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: {"store_description": description},
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
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postShopImage(
      int id, BuildContext context, File shopImage) async {
    print(shopImage.path);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$id/';
    print('Requesting URL: $url');

    FormData formData = FormData.fromMap({
      "display_image": await MultipartFile.fromFile(
        shopImage.path,
        filename: basename(shopImage.path),
      ),
    });

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: formData,
        options: Options(
          responseType: ResponseType.json,
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postShopTiming(
      int id, BuildContext context, String openTime, String closeTime) async {
    print(openTime);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$id/';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: {"opening_time": openTime, "closing_time": closeTime},
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
        return VendorModel.fromMap(response.data);
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

  Future<dynamic> postShopDetails(
      UpdateShopModel model, BuildContext context, int id) async {
    print("inside");
    try {
      print("inside try");
      // Create FormData for file uploads
      SVProgressHUD.show();
      FormData formData = FormData.fromMap({
        "business_name": model.business_name,
        "contact_number": model.contact_number,
        "address": model.address,
        "city": model.city,
        "state": model.state,
        "pincode": model.pincode,
        "store_type":model.store_type,
        "fssai_no": model.fssai_no,
        "bussiness_location": model.bussiness_location,
        "business_landmark": model.business_landmark,

        // Conditionally add fssai_certicate if not null
        if (model.fssai_certicate != null)
          "fssai_certicate": await MultipartFile.fromFile(
            model.fssai_certicate!.path,
            filename: basename(model.fssai_certicate!.path),
          ),

        // Conditionally add license if not null
        if (model.license != null)
          "license": await MultipartFile.fromFile(
            model.license!.path,
            filename: basename(model.license!.path),
          ),
      });

      final url = '${baseUrl}vendors/vendors/$id/';

      // Perform the POST request
      Response response = await _dio.patch(
        url, // Replace with your API endpoint
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
        print("Registration successful: ${response.data}");

        return VendorModel.fromMap(response.data);
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
}


