import 'package:flutter/material.dart';

class Suit extends StatefulWidget {
  String gender;
  Suit({Key key, @required this.gender}) : super(key: key);

  @override
  State<Suit> createState() => _SuitState();
}

class _SuitState extends State<Suit> {
  String itemType = 'Suit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Suit'),
      ),
    );
  }
}
