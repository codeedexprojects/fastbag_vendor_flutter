import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';

class GroceryRepository {
  final dio = Dio();
  addProduct(data) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        "weights": jsonEncode(data["weights"]), // Encode weights as JSON
      });

      // get token
      // final token = StoreManager().getAccessToken;

      const token =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5MTQ2NjA4LCJpYXQiOjE3Mzc2MTA2MDgsImp0aSI6IjcyNWYyNzhhYmE5MjQyOTU5OTNhOWYzNmQ4M2VhNGE5IiwidXNlcl9pZCI6MX0.cQvNtygE7CC7Vvcsyxpzr3YdeiVSIbKMw4ZMZuGw9nQ';
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
      throw Exception("Unexpected error occurred. Please try again.");
    }
  }
}
