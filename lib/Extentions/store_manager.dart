// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TokenManager {
//   final _storage = const FlutterSecureStorage();

//   // Save tokens
//   Future<void> saveTokens(String accessToken, String refreshToken) async {
//     await _storage.write(key: 'access_token', value: accessToken);
//     await _storage.write(key: 'refresh_token', value: refreshToken);
//   }

//   // Get access token
//   Future<String?> getAccessToken() async {
//     return await _storage.read(key: 'access_token');
//   }

//   // Get refresh token
//   Future<String?> getRefreshToken() async {
//     return await _storage.read(key: 'refresh_token');
//   }

//   // Clear all tokens
//   Future<void> clearTokens() async {
//     await _storage.delete(key: 'access_token');
//     await _storage.delete(key: 'refresh_token');
//   }
// }

import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class StoreManager {
  // Save tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<void> saveApprovalStatus(bool isApproved) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isApproved', isApproved);
  }

  Future<void> saveVendorId(int vendorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('vendorId', vendorId);
  }

  Future<int?> getVendorId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('vendorId');
  }

  // Get access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  Future<bool?> getIsApproved() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isApproved');
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('isApproved');
  }

  Future<void> saveStoreType(String vendorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('vendorType', vendorId);
  }

  Future<String?> getStoreType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('vendorType');
  }

  Future<String?> getOtp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('otp');
  }
}
