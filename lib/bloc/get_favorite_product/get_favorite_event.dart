import 'package:equatable/equatable.dart';

abstract class GetFavoriteProductEvent extends Equatable {
  const GetFavoriteProductEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteProduct extends GetFavoriteProductEvent {
  const FetchFavoriteProduct();
}
