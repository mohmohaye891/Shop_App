import 'package:flutter/material.dart';
import 'package:shop_app/common/preference_util.dart';
import 'package:shop_app/module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/login/login_cubit.dart';
import 'package:shop_app/bloc/login/login_state.dart';
import 'package:shop_app/data/model/login/login.dart';

import '../home/home_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _userName = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(getIt.call()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoginSuccess) {
            Login response = state.loginResponse;
            debugPrint('Token : ${response.token}');
            String? token = response.token;
            debugPrint('Response Token : $token');
            // Save login token
            PreferencesUtil.saveLoginUserData(token ?? '');
            Future.delayed(Duration.zero, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeNavigationScreen()));
            });
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter user name';
                          }
                          // Return null if the entered username is valid
                          return null;
                        },
                        onChanged: (value) => _userName = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            final bool? isValid =
                                _formKey.currentState?.validate();
                            if (isValid == true) {
                              debugPrint('Everything looks good!');
                              debugPrint(_userName);
                              debugPrint(_password);
                              context
                                  .read<LoginCubit>()
                                  .login(_userName, _password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
