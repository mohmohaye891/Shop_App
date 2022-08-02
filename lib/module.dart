import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/bloc/get_product/bloc.dart';
import 'package:shop_app/data/api/api_service.dart';
import 'package:shop_app/data/product_repository.dart';
import 'bloc/get_favorite_product/get_favorite_bloc.dart';
import 'package:shop_app/bloc/get_category/get_category_cubit.dart';
import 'package:shop_app/bloc/get_product_by_category/get_product_by_category_cubit.dart';

var getIt = GetIt.I;

void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  Repository productRepository = Repository(getIt.call());
  getIt.registerLazySingleton(() => productRepository);

  GetCategoryCubit getCategoryCubit = GetCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => getCategoryCubit);

  GetProductByCategoryCubit getProductByCategoryCubit =
      GetProductByCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => getProductByCategoryCubit);

  FavoriteBloc getFavoriteProductBloc = FavoriteBloc(getIt.call());
  getIt.registerLazySingleton(() => getFavoriteProductBloc);

  GetProductBloc getProductBloc = GetProductBloc(getIt.call());
  getIt.registerLazySingleton(() => getProductBloc);
}
