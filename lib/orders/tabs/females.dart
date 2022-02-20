import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/orders/tabs/shorts.dart';
import 'package:flutter_ecommerce_app/orders/tabs/suit.dart';
import 'package:flutter_ecommerce_app/orders/tabs/t_shirt.dart';
import 'package:flutter_ecommerce_app/orders/tabs/trousers.dart';

class Females extends StatefulWidget {
  const Females({Key key}) : super(key: key);

  @override
  State<Females> createState() => _FemalesState();
}

class _FemalesState extends State<Females> with SingleTickerProviderStateMixin {
  TabController _controller;
  String gender = 'female';
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
