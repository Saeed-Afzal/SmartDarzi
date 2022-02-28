import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';

//import 'package:geolocator/geolocator.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({
    Key key,
  }) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // final _preferenceService = SharedPref();
  // ignore: non_constant_identifier_names
  TextEditingController Password = TextEditingController();

  //Position _currentPosition;
  String date = "";
  DateTime selectedDate = DateTime.now();
  var userCus = DateTime.now().toString();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  bool _passVisible = false;
  @override
  void initState() {
    _passVisible = false;
    super.initState();
  }

  editName() async {
    try {
      await firestoreInstance
          .collection('userinfo')
          .doc(auth.currentUser.uid)
          .update({
        'password': Password.text,
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width,
          height: size.height,
          child: Card(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Changing your email"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: Password,
                      obscureText: !_passVisible,
                      decoration: InputDecoration(
                        fillColor: Colors.blue.shade100,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(),
      // backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Change Password",
        // style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: Text("Are you sure you want to proceed?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        editName();
                      },
                    )
                  ],
                );
              },
            );
          },
          child: Icon(
            Icons.check,
            size: 26.0,
          ),
        ),
        SizedBox(width: defaultPadding),
      ],
    );
  }
}
