import 'package:equatable/equatable.dart';
import 'package:shop_app/data/model/product/product.dart';

abstract class GetFavoriteProductState extends Equatable {
  const GetFavoriteProductState();

  @override
  List<Object> get props => [];
}

class GetFavoriteProductInitial extends GetFavoriteProductState {}

class GetFavoriteProductSuccess extends GetFavoriteProductState {
  final List<Product> favoriteProducts;

  const GetFavoriteProductSuccess(this.favoriteProducts);
  @override
  List<Object> get props => [favoriteProducts];
}

class GetFavoriteProductFail extends GetFavoriteProductState {
  final String error;

  const GetFavoriteProductFail(this.error);
  @override
  List<Object> get props => [error];
}
