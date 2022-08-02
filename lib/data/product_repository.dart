import 'package:shop_app/common/preference_util.dart';
import 'package:shop_app/data/model/category/category.dart';
import 'package:shop_app/data/model/login/login.dart';

import 'api/api_service.dart';
import 'package:shop_app/data/model/product/product.dart';

class Repository {
  final ApiService _apiService;

  Repository(this._apiService);

  Future<List<Product>> getAllProduct() => _apiService.getAllProduct();

  Future<Category> getCategory() => _apiService.getCategory();

  Future<Login> login(String userName, String password) =>
      _apiService.loginPage(userName, password);

  Future<List<Product>> getProductByCategory(String categoryName) =>
      _apiService.getProductByCategory(categoryName);
}
