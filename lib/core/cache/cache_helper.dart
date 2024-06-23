// import 'package:shared_preferences/shared_preferences.dart';
// class CacheData {
//   static late SharedPreferences sharedpreferences;
//   static cacheInitialization() async {
//     sharedpreferences = await SharedPreferences.getInstance();
//   }
//   static Future<bool> setData(
//       {required String key, required dynamic value}) async {
//     if (value is int) {
//       await sharedpreferences.setInt(key, value);
//       return true;
//     } else if (value is String) {
//       await sharedpreferences.setString(key, value);
//       return true;
//     } else if (value is double) {
//       await sharedpreferences.setDouble(key, value);
//       return true;
//     } else if (value is bool) {
//       await sharedpreferences.setBool(key, value);
//       return true;
//     }
//     return false;
//   }
//   static dynamic getData({required String key}) {
//     return sharedpreferences.get(key);
//   }
//   static Future<bool> deleteData({required String key}) async {
//     return await sharedpreferences.remove(key);
//   }
// }