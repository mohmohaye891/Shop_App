import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/get_product/bloc.dart';
import 'package:shop_app/common/constants.dart';
import 'package:shop_app/data/model/product/product.dart';

import '../search/search_category_view.dart';
import '../../../widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<Product> bindProductData = [];

  List<Product> products = [];

  int pageCount = 1;

  int totalProductCount = 0;

  int totalPageCount = 0;

  List<String> categories = [
    "All products",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final favoriteBloc = BlocProvider.of<GetProductBloc>(context);
    favoriteBloc.add(FetchProductEvent(
        pageCount: pageCount, isAllProduct: true, categoryName: ''));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    pageCount = pageCount + 1;
    if (pageCount <= totalPageCount) {
      context.read<GetProductBloc>().add(FetchProductEvent(
          pageCount: pageCount, isAllProduct: true, categoryName: ''));
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          if (state is GetLimitProductSuccess) {
            products = state.limitProducts;
            totalProductCount = state.totalProductCount;
            totalPageCount = (totalProductCount / 10.0).ceil();
            bindProductData.addAll(products);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8.0),
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: bindProductData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                        product: bindProductData[index],
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        color: Colors.black45,
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.grey,
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
        const SizedBox(width: 10.0)
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Column(
          children: [_buildSearchBar(), _buildCategories()],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromRGBO(204, 204, 204, 1)),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return Colors.transparent;
            },
          ),
        ),
        onPressed: () {
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchCategory()));
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: const <Widget>[
              Icon(
                Icons.search,
                size: 18,
                color: AppColors.neutral_2,
              ),
              SizedBox(width: 8),
              Text(
                'Search here...',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => _buildCategory(index),
        ),
      ),
    );
  }

  Widget _buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        bindProductData.clear();
        totalProductCount = 0;
        pageCount = 1;

        if (selectedIndex != 0) {
          String category = categories[index];
          debugPrint(categories[index]);
          context.read<GetProductBloc>().add(FetchProductEvent(
              pageCount: pageCount,
              isAllProduct: false,
              categoryName: category));
        }
        if (selectedIndex == 0) {
          bindProductData.clear();
          context.read<GetProductBloc>().add(FetchProductEvent(
              pageCount: pageCount, isAllProduct: true, categoryName: ''));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? AppColors.neutral_1
                    : AppColors.neutral_2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
