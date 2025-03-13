import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';

class GroceryRepository {
  final dio = Dio();
  addProduct(data) async {
    try {
      final formData = FormData.fromMap(data);

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

      throw Exception('Product Adding Failed $e');
      // if (e.response != null) {
      //   String errorMessage = '';
      //   final responseData = e.response!.data;
      //   if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
      //     errorMessage =
      //         responseData.values.first.toString(); // Get first value
      //   }
      //   print('---------------->${errorMessage}');

      //   throw Exception(errorMessage.isNotEmpty
      //       ? errorMessage
      //       : 'Registration Failed failed');
      // } else {
      //   throw Exception('Network error: ${e.message}');
      // }
    } catch (e) {
      print(e.toString());
    }
  }
}
