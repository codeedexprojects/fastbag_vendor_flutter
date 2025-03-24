import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Features/Dashboard/model/dish_class.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Commons/base_url.dart';

class DashRepository{
  Future<DishClass?> fetchDishCount() async {
    try {
      SVProgressHUD.show();
      final prefs = await SharedPreferences.getInstance();
      var vendorId = prefs.getInt('vendor_id');
      var tokenId = prefs.getString('access_token');
      var headers = {
        'Authorization': 'Bearer $tokenId'
      };
      print('${vendorId}');
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}vendors/analytics/$vendorId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        SVProgressHUD.dismiss();
        return DishClass.fromJson(response.data);

      }
    }  on DioException catch (e) {
      SVProgressHUD.dismiss();
      print("error $e");
    }
  }
}


