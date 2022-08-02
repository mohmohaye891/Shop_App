import 'dart:async';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../data/product_repository.dart';
import '../../data/model/product/product.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final Repository _repository;

  GetProductBloc(this._repository) : super(GetLimitProductInitial()) {
    on<FetchProductEvent>(_fetProductEvent);
  }

  Future<void> _fetProductEvent(
      FetchProductEvent event, Emitter<GetProductState> emit) async {
    emit(GetLimitProductInitial());
    try {
      final List<Product> products = [];
      int totalProductCount = 0;
      if (event.isAllProduct) {
        final response = await _repository.getAllProduct();
        totalProductCount = response.length;
        for (int i = (event.pageCount * 10) - 10;
            i < event.pageCount * 10;
            i++) {
          products.add(response[i]);
        }
      } else {
        final response =
            await _repository.getProductByCategory(event.categoryName);
        totalProductCount = response.length;
        products.addAll(response);
      }
      emit(GetLimitProductSuccess(products, totalProductCount));
    } catch (error) {
      emit(const GetLimitProductFail("Error"));
    }
  }
}
