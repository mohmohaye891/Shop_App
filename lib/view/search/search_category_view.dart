import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/get_category/get_category_cubit.dart';
import 'package:shop_app/bloc/get_category/get_category_state.dart';
import 'package:shop_app/view/search/search_category_result_view.dart';

class SearchCategory extends StatefulWidget {
  const SearchCategory({Key? key}) : super(key: key);

  @override
  _SearchCategoryState createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  int _selectedIndex = 0;

  List<String> categories = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetCategoryCubit>(context).getCategory();
    return BlocBuilder<GetCategoryCubit, GetCategoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 30.0),
                child: Text(
                  'Search by Category',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildSearchCategoryButtonList(categories: categories),
              const SizedBox(height: 30.0),
              _buildSearchButton(categories: categories)
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchButton({required List<String> categories}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              child: const Text('Search'),
              onPressed: () {
                String category = categories[_selectedIndex];
                debugPrint(categories[_selectedIndex]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchCategoryResultScreen(
                              category: category,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  //primary: const Color(0xfffe8f01),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: _buildAppbarTitle(),
    );
  }

  Widget _buildAppbarTitle() {
    return const Text(
      'Filter Category',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchCategoryButtonList({required List<String> categories}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 4,
          children: List.generate(
            categories.length,
            (index) {
              return ChoiceChip(
                selected: _selectedIndex == index,
                label: Text(categories[index]),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }
                },
                selectedColor: Colors.blue,
                backgroundColor: Colors.black12,
              );
            },
          ),
        ),
      ),
    );
  }
}
