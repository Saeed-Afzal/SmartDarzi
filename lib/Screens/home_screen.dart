// import 'package:animation_2/controllers/home_controller.dart';
// import 'package:animation_2/models/Product.dart';
// import 'package:animation_2/screens/deatils/details_screen.dart';
// import 'package:animation_2/screens/home/components/cart_detailsview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/Screens/Component/header.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Screens/controller/home_controller.dart';
//import 'package:flutter_ecommerce_app/widgets/products_card.dart';

// import 'components/cart_details_view.dart';
// import 'components/cart_short_view.dart';
// import 'components/header.dart';
// import 'components/product_card.dart';

// Today i will show you how to implement the animation
// So starting project comes with the UI
// Run the app

class HomeScreen extends StatelessWidget {
  final controller = HomeController();

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
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
            color: Color(0xFFEAEAEA),
            child: Stack(
              children: [
                Positioned(child: Text("hello world")),
                Positioned(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(2 * 1.5),
                              bottomRight: Radius.circular(2 * 1.5),
                            )),
                        child: Text("Hellow rod"))),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: cartBarHeight,
                    child: GestureDetector(
                      onVerticalDragUpdate: _onVerticalGesture,
                      child: Container(
                        color: Colors.red,
                      ),
                    )), // Header
                AnimatedPositioned(
                  duration: panelTransition,
                  top: controller.homeState == HomeState.normal
                      ? 0
                      : -headerHeight,
                  right: 0,
                  left: 0,
                  height: headerHeight,
                  child: HomeHeader(),
                ),
              ],
            )),
      ),
    );
  }
}
