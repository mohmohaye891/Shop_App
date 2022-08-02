import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/get_product_by_category/get_product_by_category_state.dart';
import '../../data/product_repository.dart';

class GetProductByCategoryCubit extends Cubit<GetProductByCategoryState> {
  final Repository _repository;

  GetProductByCategoryCubit(this._repository)
      : super(GetProductByCategoryInitial());

  void getProductByCategory(String categoryName) {
    emit(GetProductByCategoryInitial());
    _repository
        .getProductByCategory(categoryName)
        .then((value) => emit(GetProductByCategorySuccess(value)))
        .catchError((e) => emit(const GetProductByCategoryFail("Error")));
  }
}
