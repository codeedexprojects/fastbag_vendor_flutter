import 'package:shared_preferences/shared_preferences.dart';

class FbStore {
  static Future<void> storeData(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (value is String) {
    await prefs.setString(key, value);
  } else if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  } else {
    // Handle unsupported data types or consider using a serialization library
    throw Exception('Unsupported data type: $value');
  }
}

static Future<dynamic> retrieveData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}
}