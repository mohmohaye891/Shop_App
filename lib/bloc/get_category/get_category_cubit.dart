import 'package:bloc/bloc.dart';
import 'package:shop_app/data/product_repository.dart';
import 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  final Repository _repository;
  GetCategoryCubit(this._repository) : super(GetCategoryInitial());

  void getCategory() {
    emit(GetCategoryInitial());
    _repository
        .getCategory()
        .then((value) => emit(GetCategorySuccess(value.category)))
        .catchError((e) => emit(const GetCategoryFail("Error")));
  }
}
