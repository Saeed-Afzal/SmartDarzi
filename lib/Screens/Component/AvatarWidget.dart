import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key key, this.name, this.fontSize = 40, this.radius = 55})
      : super(key: key);
  final String name;
  final double fontSize;
  final double radius;

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  bool defaultAvatar = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
          backgroundColor: HexColor('#0000ff'),
          radius: widget.radius,
          child: Text(
            _nameInitials(widget.name),
            style: TextStyle(fontSize: widget.fontSize),
          )),
    );
  }

  String _nameInitials(String value) {
    try {
      var values = value.split(' ');
      var initials = StringBuffer();
      int count = 0;
      values.forEach((element) {
        if (count == 2) return;
        if (element.isNotEmpty) initials.write(element[0]);
        count++;
      });
      return initials.toString();
    } catch (error) {
      print(error);
      return "-";
    }
  }
}
