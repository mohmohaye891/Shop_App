import 'package:bloc/bloc.dart';
import 'package:shop_app/common/preference_util.dart';
import 'package:shop_app/data/product_repository.dart';
import './bloc.dart';
import '../../data/product_repository.dart';

class FavoriteBloc
    extends Bloc<GetFavoriteProductEvent, GetFavoriteProductState> {
  final Repository _repository;

  FavoriteBloc(this._repository) : super(GetFavoriteProductInitial()) {
    on<FetchFavoriteProduct>(_fetFavoriteProduct);
  }

  Future<void> _fetFavoriteProduct(
      FetchFavoriteProduct event, Emitter<GetFavoriteProductState> emit) async {
    emit(GetFavoriteProductInitial());
    try {
      final favProduct = await PreferencesUtil.getFavoriteProductData();
      emit(GetFavoriteProductSuccess(favProduct));
    } catch (error) {
      emit(const GetFavoriteProductFail('error'));
    }
  }
}
