import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/get_favorite_product/bloc.dart';

import '../../data/model/product/product.dart';
import '../../widgets/item_card.dart';
import '../home/home_navigation.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreen createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(const FetchFavoriteProduct());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeNavigationScreen(),
              ),
            );
          },
        ),
        title: const Center(child: Text('Favorite Products')),
      ),
      body: BlocBuilder<FavoriteBloc, GetFavoriteProductState>(
        builder: (context, state) {
          if (state is GetFavoriteProductSuccess) {
            List<Product> products = state.favoriteProducts;
            debugPrint('Favorite Product : $products');
            if (products.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                          product: products[index],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('No Favorite Data'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
