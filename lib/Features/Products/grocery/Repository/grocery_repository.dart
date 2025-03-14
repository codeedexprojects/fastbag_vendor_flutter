import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';

class GroceryRepository {
  final dio = Dio();
  Future fetchGroceryCategories() async {
    try {
      String? storeType = await StoreManager().getStoreType();
      print("----------------------->$storeType");

      Response response = await dio.get(
        "${baseUrl}vendors/categories/filter/?store_type_name=$storeType",
      );

      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        // Server returned a response (status code other than 2xx)
        throw e.response?.data ??
            'Failed to fetch categories. Please try again.';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw 'Connection timed out. Please check your internet and try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      } else {
        throw 'Something went wrong. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  Future fetchGrocerySubCategory() async {
    try {
      String? token = await StoreManager().getAccessToken();
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token", // Add token to header
        },
      );
      Response response = await dio.get("${baseUrl}grocery/gro-Subcategories/list/",
          options: options);
      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        // Server returned a response (status code other than 2xx)
        throw e.response?.data ??
            'Failed to fetch Sub categories. Please try again.';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw 'Connection timed out. Please check your internet and try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      } else {
        throw 'Something went wrong. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  addProduct(data) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        "weights": jsonEncode(data["weights"]), // Encode weights as JSON
      });

      // get token
      final token = await StoreManager().getAccessToken();

      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token", // Add token to header
          "Content-Type": "multipart/form-data",
        },
      );
      Response response = await dio.post('${baseUrl}grocery/products/',
          data: formData, options: options);
      print('Status code ----> ${response.statusCode}');
      print("response ------>${response.data}");

      return response;
    } on DioException catch (e) {
      print(e.response?.data);

      if (e.response != null) {
        final responseData = e.response!.data;

        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          for (var value in responseData.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString(); // Show only the first error
            }
          }
        }
      }

      throw "Network error: ${e.message}";
    } catch (e) {
      print(e.toString());
      throw "Unexpected error occurred. Please try again.";
    }
  }
}
