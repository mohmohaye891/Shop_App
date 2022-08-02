import 'package:equatable/equatable.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends GetProductEvent {
  final int pageCount;
  final bool isAllProduct;
  final String categoryName;
  const FetchProductEvent(
      {required this.pageCount,
      required this.isAllProduct,
      required this.categoryName});
}
