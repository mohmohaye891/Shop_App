import 'package:equatable/equatable.dart';

abstract class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class GetCategoryInitial extends GetCategoryState {}

class GetCategorySuccess extends GetCategoryState {
  final List<String> categories;

  const GetCategorySuccess(this.categories);
  @override
  List<Object> get props => [categories];
}

class GetCategoryFail extends GetCategoryState {
  final String error;

  const GetCategoryFail(this.error);
  @override
  List<Object> get props => [error];
}
