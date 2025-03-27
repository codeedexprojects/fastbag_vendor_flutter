import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:path/path.dart';

import '../../../Commons/base_url.dart';
import '../../../Extentions/store_manager.dart';
import '../Model/profile_shop_model.dart';
import '../Model/update_shop_model.dart';

class ProfileShopRepository{
  final Dio _dio=Dio();
  Future<dynamic> getShopProfile( BuildContext context) async {
    SVProgressHUD.show();
    int? vendorId=await StoreManager().getVendorId();

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
        return ProfileShopModel.fromJson(response.data);
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


  Future<dynamic> updateShopProfile( BuildContext context,Map<String, dynamic> updatesMap) async {
    SVProgressHUD.show();
    print(updatesMap);
    int? vendorId=await StoreManager().getVendorId();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data: jsonEncode(updatesMap),
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
        return ProfileShopModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusMessage}");
      }
    } on DioException catch (dioError) {
      print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${dioError.response}");
      print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${dioError.error}");
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


  Future<dynamic> updateShopLogo(BuildContext context, File logoFile) async {
    int? vendorId=await StoreManager().getVendorId();
    print(logoFile.path);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId/';
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
        return ProfileShopModel.fromJson(response.data);
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


  Future<dynamic> updateShopImage(BuildContext context, File shopImage) async {
    int? vendorId=await StoreManager().getVendorId();
    print(shopImage.path);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId/';
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
        return ProfileShopModel.fromJson(response.data);
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

  Future<dynamic> updateShopDescription(BuildContext context, String Description) async {
    int? vendorId=await StoreManager().getVendorId();
    print(Description);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId/';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data:{'store_description':Description},
        options: Options(
          responseType: ResponseType.json,
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        return ProfileShopModel.fromJson(response.data);
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

  Future<dynamic> updateShopTime(BuildContext context, String openTime,String closingTime) async {
    int? vendorId=await StoreManager().getVendorId();
    print(openTime);
    SVProgressHUD.show();

    // Log the URL to ensure it is correctly formatted
    final url = '${baseUrl}vendors/vendors/$vendorId/';
    print('Requesting URL: $url');

    try {
      String token = await StoreManager().getAccessToken() as String;
      // Add the authorization header with the token
      _dio.options.headers = {"Authorization": "Bearer $token"};
      print(token);
      // Simplified GET request
      var response = await _dio.patch(
        url,
        data:{'opening_time':openTime,'closing_time':closingTime},
        options: Options(
          responseType: ResponseType.json,
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response received successfully!");
        print(response.data);
        return ProfileShopModel.fromJson(response.data);
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

  Future<dynamic> updateShopDetails(
      UpdateShopModel model, BuildContext context) async {
    print("inside");
    int? vendorId=await StoreManager().getVendorId();
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
        "store_type": model.store_type,
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

      final url = '${baseUrl}vendors/vendors/$vendorId/';

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

        return ProfileShopModel.fromJson(response.data);
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