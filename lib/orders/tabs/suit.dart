import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/Screens/Component/cardshortdetail.dart';
import 'package:flutter_ecommerce_app/Screens/DetailScreen.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Screens/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/Screens/model/product.dart';
import 'package:flutter_ecommerce_app/firebase_data/data_firebase.dart';
import 'package:flutter_ecommerce_app/orders/productpage.dart';
import 'package:flutter_ecommerce_app/widgets/products_card.dart';

class Suit extends StatefulWidget {
  String gender;
  Suit({Key key, @required this.gender}) : super(key: key);

  @override
  State<Suit> createState() => _SuitState();
}

class _SuitState extends State<Suit> {
  String itemType = 'suit';
  List _productsData = [];
  bool _isLoading = true;
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    DatabaseManager data =
        DatabaseManager(gender: widget.gender, itemType: itemType);
    try {
      _productsData = await data.getProductsData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _productsData == null
                ? Center(child: Text('No product to show'))
                : SafeArea(
                    bottom: false,
                    child: Container(
                      color: Color(0xFFEAEAEA),
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, _) {
                          return LayoutBuilder(
                              builder: (context, BoxConstraints constraints) {
                            return Stack(children: [
                              AnimatedPositioned(
                                duration: panelTransition,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(defaultPadding * 1.5),
                                      bottomRight:
                                          Radius.circular(defaultPadding * 1.5),
                                    ),
                                  ),
                                  child: GridView.builder(
                                    itemCount: _productsData.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      mainAxisSpacing: defaultPadding,
                                      crossAxisSpacing: defaultPadding,
                                    ),
                                    itemBuilder: (ctx, index) => ProductsCard(
                                      name: _productsData[index]['name'],
                                      imageUrl: _productsData[index]['image']
                                          [0],
                                      price: _productsData[index]['price'],
                                      press: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              reverseTransitionDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  FadeTransition(
                                                opacity: animation,
                                                child: ProductPage(
                                                  productData: ProductData(
                                                      name: _productsData[index]
                                                          ['name'],
                                                      price:
                                                          _productsData[index]
                                                              ['price'],
                                                      images: List<String>.from(
                                                          _productsData[index]
                                                              ['image'])),
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              // AnimatedPositioned(
                              //   duration: panelTransition,
                              //   bottom: 0,
                              //   left: 0,
                              //   right: 0,
                              //   height: controller.homeState == HomeState.normal
                              //       ? cartBarHeight
                              //       : (constraints.maxHeight - cartBarHeight),
                              //   child: GestureDetector(
                              //     onVerticalDragUpdate: _onVerticalGesture,
                              //     child: Container(
                              //       padding:
                              //           const EdgeInsets.all(defaultPadding),
                              //       color: Color(0xFFEAEAEA),
                              //       alignment: Alignment.topLeft,
                              //       child: AnimatedSwitcher(
                              //         duration: panelTransition,
                              //         child:
                              //             // controller.homeState ==
                              //             //         HomeState.normal
                              //             CardShortView(controller: controller)
                              //         // : CartDetailsView(
                              //         //     controller: controller)
                              //         ,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // AnimatedPositioned(
                              //   duration: panelTransition,
                              //   top: controller.homeState == HomeState.normal
                              //       ? 0
                              //       : -headerHeight,
                              //   right: 0,
                              //   left: 0,
                              //   height: headerHeight,
                              //   child: HomeHeader(),
                              // ),
                            ]);
                          });
                        },
                      ),
                    ),
                  ));
  }
}
