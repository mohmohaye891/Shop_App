import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/get_product_by_category/get_product_by_category_cubit.dart';
import 'package:shop_app/bloc/get_product_by_category/get_product_by_category_state.dart';
import 'package:shop_app/data/model/product/product.dart';

import '../../widgets/item_card.dart';

class SearchCategoryResultScreen extends StatefulWidget {
  final String category;

  const SearchCategoryResultScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _SearchCategoryResultScreenState createState() =>
      _SearchCategoryResultScreenState();
}

class _SearchCategoryResultScreenState
    extends State<SearchCategoryResultScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetProductByCategoryCubit>(context)
        .getProductByCategory(widget.category);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: BlocBuilder<GetProductByCategoryCubit, GetProductByCategoryState>(
        builder: (context, state) {
          if (state is GetProductByCategorySuccess) {
            List<Product> products = state.products;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //_buildCategories(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
