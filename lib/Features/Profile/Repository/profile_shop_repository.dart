import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

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
}