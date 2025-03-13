import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';

class GroceryRepository {
  final dio = Dio();
  addProduct(data) {
    try {
      final formData = FormData.fromMap(data);
      dio.post('${baseUrl}grocery/products/', data: formData);
    } on DioException catch (e) {
      print(e);
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
