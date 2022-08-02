import 'package:equatable/equatable.dart';
import 'package:shop_app/data/model/product/product.dart';

abstract class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

class GetLimitProductInitial extends GetProductState {}

class GetLimitProductSuccess extends GetProductState {
  final List<Product> limitProducts;
  final int totalProductCount;

  const GetLimitProductSuccess(this.limitProducts, this.totalProductCount);
  @override
  List<Object> get props => [limitProducts, totalProductCount];
}

class GetLimitProductFail extends GetProductState {
  final String error;

  const GetLimitProductFail(this.error);
  @override
  List<Object> get props => [error];
}
