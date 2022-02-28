import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
//import 'package:geolocator/geolocator.dart';

class ChangeMobileNumber extends StatefulWidget {
  ChangeMobileNumber({
    Key key,
  }) : super(key: key);
  @override
  _ChangeMobileNumberState createState() => _ChangeMobileNumberState();
}

class _ChangeMobileNumberState extends State<ChangeMobileNumber> {
  // final _preferenceService = SharedPref();

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

  @override
  void initState() {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Changing your name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      // isDense: true,
                      // filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: MaterialButton(
                      onPressed: () => {},
                      child: Text('REGISTER'),
                    ),
                  ),
                ),
              ],
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
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  // content: Text(.text),
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
