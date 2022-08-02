import 'package:flutter/material.dart';
import 'package:shop_app/bloc/get_product/bloc.dart';
import 'package:shop_app/module.dart';
import 'common/preference_util.dart';
import 'view/home/home_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view/login/login_view.dart';
import 'bloc/get_favorite_product/get_favorite_bloc.dart';
import 'package:shop_app/bloc/get_category/get_category_cubit.dart';
import 'package:shop_app/bloc/get_product_by_category/get_product_by_category_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await PreferencesUtil.getLoginUserData();
  locator();
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({Key? key, required this.token}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetProductBloc>(
          create: (context) => getIt.call(),
        ),
        BlocProvider<GetCategoryCubit>(
          create: (context) => getIt.call(),
        ),
        BlocProvider<GetProductByCategoryCubit>(
          create: (context) => getIt.call(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => getIt.call(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: (token == null || token!.isEmpty)
            ? const LoginScreen()
            : const HomeNavigationScreen(),
      ),
    );
  }
}
