import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/widgets/TextFieldWidget.dart';
//import 'package:geolocator/geolocator.dart';

class ChangeName extends StatefulWidget {
  String name;
  ChangeName({Key key, this.name}) : super(key: key);
  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController nameField = new TextEditingController();
  // final _preferenceService = SharedPref();
  Future getUserData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      var users = await FirebaseFirestore.instance
          .collection('userinfo')
          .doc(auth.currentUser.uid)
          .get();
      return users;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }





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
    ename.text = widget.name;
    super.initState();
  }

  void saveCustomization() {
    // final dataView = Data(guid: "2321312312321", isCustomized: true);
    print("Save Customization");
    // _preferenceService.saveCustomization(dataView);
  }
//edit name

 final ename= TextEditingController();


  editName() async {
    try {
      await firestoreInstance
          .collection('userinfo')
          .doc(auth.currentUser.uid)
          .update({
        'name': ename.text,
      });
      // Navigator.of(context).pop(userCus);

    } catch (e) {
      print(e);
    }
  }

  // @override
  void dispose() {
    super.dispose();
    // addressController.dispose();
    ename.dispose();

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
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: ename,
                    decoration: InputDecoration(
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
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
        "Change Name",
        // style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            editName();
            // print(ename);
            // saveCustomization();
          },
          child: GestureDetector(
            onTap: () {
              editName();
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       // Retrieve the text the that user has entered by using the
              //       // TextEditingController.
              //       content: Text(nameField.text),
              //     );
              //   },
              // );
            },
            child: Icon(
              Icons.check,
              size: 26.0,
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
      ],
    );
  }
}
