import 'package:retrofit/retrofit.dart';
import 'package:shop_app/data/model/login/login.dart';
import 'package:shop_app/data/model/product/product.dart';
import 'package:dio/dio.dart';
import '../model/category/category.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com/")
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);

  @GET('products')
  Future<List<Product>> getAllProduct();

  @GET('products/categories/')
  Future<Category> getCategory();

  @GET('products/category/{categoryName}')
  Future<List<Product>> getProductByCategory(@Path() String categoryName);

  @POST("auth/login")
  @FormUrlEncoded()
  Future<Login> loginPage(
      @Field("username") userName, @Field("password") password);
}
