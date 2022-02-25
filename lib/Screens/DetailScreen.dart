import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/Screens/Component/price.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Screens/model/product.dart';
//import 'package:flutter_ecommerce_app/Screens/model/product.dart';
//import 'dart:math' as math;
import 'Component/Card_counter.dart';
import 'model/data.dart';

//import 'components/cart_counter.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(
      {Key key,
      this.productData,
      @required this.onProductAdd})
      : super(key: key);

  //final Product product;
  final VoidCallback onProductAdd;
  final ProductData productData;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _cartTag = "";
  int _currentImage = 0;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0;
        i < [].length;
        i++) {
      list.add(
          i == _currentImage ? buildIndicator(true) : buildIndicator(false));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 20.0 : 8.0,
      decoration: BoxDecoration(
        gradient: isActive ? kGradient : kGradientGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(1.0),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              child: Text("Add to Cart"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.50,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  color: Color(0xFFF8F8F8),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (int page) {
                            setState(() {
                              _currentImage = page;
                            });
                          },
                          children: widget.productData.images.map((path) {
                            return Center(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: size.height * 0.50,
                                  margin: EdgeInsets.only(right: 100),
                                  child: Image.network(
                                    path,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                     widget.productData.images.length > 1
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildPageIndicator(),
                                ),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: CartCounter(),
                ),
              ],
            ),
          ),
          SizedBox(height: defaultPadding * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "hello",
                    //widget.product.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Price(amount: "20.00"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "Cabbage (comprising several cultivars of Brassica oleracea) is a leafy green, red (purple), or white (pale green) biennial plant grown as an annual vegetable crop for its dense-leaved heads. It is descended from the wild cabbage (B. oleracea var. oleracea), and belongs to the cole crops or brassicas, meaning it is closely related to broccoli and cauliflower (var. botrytis); Brussels sprouts (var. gemmifera); and Savoy cabbage (var. sabauda).",
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Fruits",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        // FavBtn(radius: 20),
        SizedBox(width: defaultPadding),
      ],
    );
  }
}
