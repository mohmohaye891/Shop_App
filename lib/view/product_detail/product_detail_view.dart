import 'package:flutter/material.dart';
import 'package:shop_app/common/preference_util.dart';
import 'package:shop_app/data/model/product/product.dart';
import 'package:shop_app/view/home/home_navigation.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final List<Product> favList = [];

  List<Product> alreadyFavoriteList = [];

  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    getAlreadyExitProduct();
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffbfbfb),
                Color(0xfff7f7f7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(context),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeNavigationScreen(),
                ),
              );
            },
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.black12,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () async {
            setState(() {
              isLiked = !isLiked;
            });
            debugPrint('Check Like : $isLiked');
            if (isLiked) {
              if (!alreadyFavoriteList
                  .map((item) => item.id)
                  .contains(widget.product.id)) {
                alreadyFavoriteList.add(widget.product);
              }
            } else {
              favList.clear();
              alreadyFavoriteList
                  .removeWhere((product) => product.id == widget.product.id);
            }
            favList.addAll(alreadyFavoriteList);
            PreferencesUtil.saveFavoriteProductData(favList);
          }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = Colors.black26,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    required Function onPressed,
  }) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(padding),
        // margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black26,
              style: isOutLine ? BorderStyle.solid : BorderStyle.none),
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: isOutLine
              ? Colors.transparent
              : Theme.of(context).backgroundColor,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8),
                blurRadius: 5,
                spreadRadius: 10,
                offset: Offset(5, 5)),
          ],
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              child: widget.product.image.toString().isNotEmpty
                  ? SizedBox(
                      width: 300.0,
                      height: 300.0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          widget.product.image.toString(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 48.0),
                      child: Image.asset(
                        'assets/images/transparent_logo.png',
                        width: 200.0,
                        height: 200.0,
                      )),
            )
          ],
        )
      ],
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.product.title!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "\$",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.red),
                              ),
                              Text(
                                "${widget.product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            children: const <Widget>[
                              Icon(Icons.star, color: Colors.yellow, size: 17),
                              Icon(Icons.star, color: Colors.yellow, size: 17),
                              Icon(Icons.star, color: Colors.yellow, size: 17),
                              Icon(Icons.star, color: Colors.yellow, size: 17),
                              Icon(Icons.star_border, size: 17),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(widget.product.description!),
      ],
    );
  }

  Future<void> getAlreadyExitProduct() async {
    alreadyFavoriteList = await PreferencesUtil.getFavoriteProductData();
    if (alreadyFavoriteList
        .map((item) => item.id)
        .contains(widget.product.id)) {
      setState(() {
        isLiked = true;
      });
    } else {
      setState(() {
        isLiked = false;
      });
    }
  }
}
