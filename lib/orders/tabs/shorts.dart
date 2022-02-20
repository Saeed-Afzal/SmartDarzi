import 'package:flutter/material.dart';

class Shorts extends StatefulWidget {
  String gender;
  Shorts({Key key, @required this.gender}) : super(key: key);

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Shorts'),
      ),
    );
  }
}
