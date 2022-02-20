import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/firebase_data/data_firebase.dart';
import 'package:flutter_ecommerce_app/orders/tabs/females.dart';
import 'package:flutter_ecommerce_app/orders/tabs/kids.dart';
import 'package:flutter_ecommerce_app/orders/tabs/males.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              text: 'Kid',
            ),
            Tab(
              text: 'Male',
            ),
            Tab(
              text: 'Female',
            ),
          ],
        ),
        title: Text('Create order'),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Kids(),
          Males(),
          Females(),
        ],
      ),
    );
  }
}
