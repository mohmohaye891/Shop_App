import 'package:bloc/bloc.dart';
import '../../data/product_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository _repository;
  LoginCubit(this._repository) : super(LoginInitial());

  void login(String userName, String password) {
    emit(LoginLoading());
    _repository
        .login(userName, password)
        .then((value) => emit(LoginSuccess(value)))
        .catchError((e) => emit(const LoginFail('Login Fail')));
  }
}
