import 'package:flutter/material.dart';

class TShirts extends StatefulWidget {
  String gender;
  TShirts({Key key, @required this.gender}) : super(key: key);

  @override
  State<TShirts> createState() => _TShirtsState();
}

class _TShirtsState extends State<TShirts> {
  String itemType = 'T-Shirts';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('T-Shirts'),
      ),
    );
  }
}
