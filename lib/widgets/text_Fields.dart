import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class MyTextField extends StatelessWidget {
  // const MyTextField({ Key? key }) : super(key: key);

  final String hintText;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;

  const MyTextField({Key key, this.hintText, this.obscureText,this.icon = Icons.person, this.controller}) : super(key: key); //for validation

  // MyTextField({required this.hintText,
  // required this.obscureText,
  // required this.controller,
  // });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      
      decoration: InputDecoration(
        icon: Icon(
            icon,
            color: HexColor('#0071bc'),
          ),
          // prefixIcon: Icon(
          //   icon,
          //   color: iconColor,
          // ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.blue),
          enabledBorder:
              UnderlineInputBorder(borderSide: 
              BorderSide(color: Colors.blue))),
    );
  }
}

class required {
}



