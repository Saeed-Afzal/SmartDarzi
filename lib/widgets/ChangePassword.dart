import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Utilities/constants.dart';
import 'package:flutter_ecommerce_app/widgets/passwordWidget.dart';
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
  TextEditingController Password = TextEditingController();
  TextEditingController CPassword = TextEditingController();

  //Position _currentPosition;
  String date = "";
  DateTime selectedDate = DateTime.now();
  var userCus = DateTime.now().toString();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // addDataToDatabase() async {
  //   try {
  //     await firestoreInstance.collection('customize').doc(userCus).set({
  //       'uid': auth.currentUser.uid,
  //       'email': auth.currentUser.email,
  //       'isCustomize': true,
  //       'colar': collarData,
  //       'daman': damanDesign,
  //       'button': buttonStyle,
  //       'shalwar': shalwarDesign,
  //       'date': userCus,
  //     });
  //     Navigator.of(context).pop(userCus);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   addressController.dispose();
  //   mySizeValue = '';
  // }
  bool _passVisible = false;
  @override
  void initState() {
    _passVisible = false;
    super.initState();
  }

  void saveCustomization() {
    // final dataView = Data(guid: "2321312312321", isCustomized: true);
    print("Save Customization");
    // _preferenceService.saveCustomization(dataView);
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
                            // Based on passwordVisible state choose the icon
                            _passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
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
        "Name",
        // style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // addDataToDatabase();
            // saveCustomization();
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
