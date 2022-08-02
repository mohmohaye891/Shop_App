import 'package:equatable/equatable.dart';
import 'package:shop_app/data/model/login/login.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Login loginResponse;

  const LoginSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class LoginFail extends LoginState {
  final String error;

  const LoginFail(this.error);
  @override
  List<Object> get props => [error];
}
