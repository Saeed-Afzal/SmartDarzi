import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/firebase_data/data_firebase.dart';
import 'package:flutter_ecommerce_app/orders/tabs/suit.dart';
import 'package:flutter_ecommerce_app/orders/tabs/shorts.dart';
import 'package:flutter_ecommerce_app/orders/tabs/t_shirt.dart';
import 'package:flutter_ecommerce_app/orders/tabs/trousers.dart';

class Kids extends StatefulWidget {
  const Kids({Key key}) : super(key: key);

  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> with SingleTickerProviderStateMixin {
  TabController _controller;
  String gender = 'kids';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    // getData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // void getData() async {
  //   DatabaseManager data = DatabaseManager();
  //   _productsData = await data.getProductsData();
  //   setState(() {
  //     // _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _controller,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'T-Shirts',
              ),
              Tab(
                text: 'Trousers',
              ),
              Tab(
                text: 'Shorts',
              ),
              Tab(
                text: 'Suit',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                TShirts(
                  gender: gender,
                ),
                Trousers(gender: gender),
                Shorts(gender: gender),
                Suit(gender: gender),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
