import 'package:equatable/equatable.dart';
import 'package:shop_app/data/model/product/product.dart';

abstract class GetProductByCategoryState extends Equatable {
  const GetProductByCategoryState();

  @override
  List<Object> get props => [];
}

class GetProductByCategoryInitial extends GetProductByCategoryState {}

class GetProductByCategorySuccess extends GetProductByCategoryState {
  final List<Product> products;

  const GetProductByCategorySuccess(this.products);
  @override
  List<Object> get props => [products];
}

class GetProductByCategoryFail extends GetProductByCategoryState {
  final String error;

  const GetProductByCategoryFail(this.error);
  @override
  List<Object> get props => [error];
}
