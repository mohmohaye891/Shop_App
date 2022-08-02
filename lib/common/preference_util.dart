import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/product/product.dart';

class PreferencesUtil {
  static void saveLoginUserData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("LOGIN_USER_DATA", token);
  }

  static getLoginUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("LOGIN_USER_DATA");
  }

  static void removeLoginUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("LOGIN_USER_DATA");
  }

  static void saveFavoriteProductData(List<Product> favProducts) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("FAVORITE_DATA", jsonEncode(favProducts));
  }

  static getFavoriteProductData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('FAVORITE_DATA') ?? '[]');
    return jsonData
        .map<Product>((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
  }
}
