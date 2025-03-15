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
}