import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/AddressScreens/AddressList.dart';
import 'package:flutter_ecommerce_app/Screens/Component/Card_counter.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Screens/model/product.dart';
import 'package:flutter_ecommerce_app/widgets/place_product_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter/cupertino.dart';
//import 'package:geolocator/geolocator.dart';

enum CollarCharacter { shirt, sherwani }
enum ButtonCharacter { flat, lapple, glass, leather }
enum DamanCharacter { round, straight }
enum shalwarCharacter { simple, trouser, straight }

class CustomiseScreen extends StatefulWidget {
  CustomiseScreen({Key key}) : super(key: key);
  @override
  _CustomiseScreenState createState() => _CustomiseScreenState();
}

class _CustomiseScreenState extends State<CustomiseScreen> {
  //Position _currentPosition;
  String date = "";
  DateTime selectedDate = DateTime.now();

  CollarCharacter _collarcharacter = CollarCharacter.shirt;
  ButtonCharacter _btncharacter = ButtonCharacter.flat;
  DamanCharacter _damancharacter = DamanCharacter.straight;
  shalwarCharacter _shalwarcharacter = shalwarCharacter.simple;

  int selectedRadio = 0;
  int _currentImage = 0;

  List<dynamic> radioOption = [
    {"value": 1, "name": "Smart Sizes"},
    {"value": 2, "name": "My Sizes"}
  ];
  List<dynamic> sizeType = [
    {"id": 1, "label": "Smart Sizes"},
    {"id": 2, "label": "My Sizes"}
  ];
  List<dynamic> sizes = [
    {"ID": 1, "Label": "Small", "ParentId": 1},
    {"ID": 2, "Label": "Medium", "ParentId": 1},
    {"ID": 3, "Label": "Large", "ParentId": 1},
  ];

  List<dynamic> sizeName = [];

  TextEditingController addressController = TextEditingController();

  File pickedImageData;
  String imageUrl = 'No image to show';

  String sizeTypeIdFirstDropdown = '2';
  String sizeIdOfFirstDropdown;
  String sizeTypeIdSecondDropdown;
  String sizeIdOfSecondDropown;
  bool _isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    mySizeValue = '';
  }

  // void _pickImageGallery() async {
  //   final picker = ImagePicker();
  //   try {
  //     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //     final pickedImageFile = File(pickedImage.path);
  //     setState(() {
  //       pickedImageData = pickedImageFile;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         'Your image is selected',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       duration: Duration(seconds: 2),
  //     ));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         '$e',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       duration: Duration(seconds: 2),
  //     ));
  //   }
  //   // Navigator.pop(context);
  // }

  // void _remove() {
  //   setState(() {
  //     _pickedImage = null;
  //   });
  //   Navigator.pop(context);
  // }

  // addDataToDatabase() async {
  //   if (sizeTypeIdFirstDropdown == '2') {
  //     if (mySizeValue == '') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //           'Please select Your size',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         duration: Duration(seconds: 2),
  //       ));
  //       return;
  //     }
  //   }
  //   if (addressController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         'Please enter your address',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       duration: Duration(seconds: 2),
  //     ));
  //     return;
  //   }
  //   if (sizeTypeIdFirstDropdown == '1') {
  //     if (sizeIdOfSecondDropown == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //           'Please enter your size',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         duration: Duration(seconds: 2),
  //       ));
  //       return;
  //     }
  //   }
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     String time = DateTime.now().toString();
  //     var name = await firestoreInstance
  //         .collection('userinfo')
  //         .doc(auth.currentUser.uid)
  //         .get();
  //     if ((pickedImageData.toString().contains('/'))) {
  //       var abc;
  //       final ref = FirebaseStorage.instance
  //           .ref()
  //           .child('usersImages')
  //           .child(name['name'] + '.jpg');
  //       await ref.putFile(pickedImageData);
  //       abc = await ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = abc;
  //       });
  //     }
  //     print('Outside of image url');
  //     await firestoreInstance
  //         .collection('userorder')
  //         .doc(auth.currentUser.uid)
  //         .collection('product')
  //         .add({
  //       'user name': name['name'],
  //       'user id': auth.currentUser.uid,
  //       'order placed': time,
  //       'product name': widget.productData.name,
  //       'size type': sizeTypeIdFirstDropdown == '1'
  //           ? sizes[int.parse(sizeIdOfSecondDropown) - 1]['Label']
  //           : '',
  //       'size name': mySizeValue,
  //       'location': addressController.text.toString(),
  //       'uploaded size': imageUrl,
  //       'isPending': true,
  //       'isCompleted': false,
  //       'isCancelled': false,
  //     });
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Navigator.of(context).pop();
  //   } catch (e) {
  //     print('$e');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // this.sizeType.add({"id": 1, "label": "Smart Sizes"});
    // this.sizeType.add({"id": 2, "label": "My Sizes"});

    // this.sizes = [
    //   {"ID": 1, "Label": "Small", "ParentId": 1},
    //   {"ID": 2, "Label": "Medium", "ParentId": 1},
    //   {"ID": 3, "Label": "Large", "ParentId": 1},
    // ];
  }

  // Future<UserAuth> _authenticateLogin() async {
  //   SharedPref localStorage = SharedPref();
  //   var authMap = await localStorage.read('authData');
  //   if (authMap != null) return UserAuth.fromJson(jsonDecode(authMap));
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: <Widget>[
              Center(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: size.height * 0.40,
                    margin: EdgeInsets.only(right: 25),
                    child: Image.asset(
                      "assets/shrt3.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kings Hubb Deal 1",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "RS 399.00",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Zinger Burger, fries & 250ml soft drink can",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 5,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Choose your Collar Design",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Select One",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: const Text(
                                '1 Required',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              backgroundColor: Colors.blue[100],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 150,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          ListTile(
                              title: Text("Shirt Collar"),
                              leading: Radio(
                                value: CollarCharacter.shirt,
                                groupValue: _collarcharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _collarcharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Sherwani Collar"),
                              leading: Radio(
                                value: CollarCharacter.sherwani,
                                groupValue: _collarcharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _collarcharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Choose your Button Style",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Select One",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: const Text(
                                '1 Required',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              backgroundColor: Colors.blue[100],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 250,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          ListTile(
                              title: Text("Flat / Simple Buttons"),
                              leading: Radio(
                                value: ButtonCharacter.flat,
                                groupValue: _btncharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _btncharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Glass Buttons"),
                              leading: Radio(
                                value: ButtonCharacter.glass,
                                groupValue: _btncharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _btncharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Leather Buttons"),
                              leading: Radio(
                                value: ButtonCharacter.leather,
                                groupValue: _btncharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _btncharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Lapple Buttons"),
                              leading: Radio(
                                value: ButtonCharacter.lapple,
                                groupValue: _btncharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _btncharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Choose your Daman Design",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Select One",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: const Text(
                                '1 Required',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              backgroundColor: Colors.blue[100],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 150,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          ListTile(
                              title: Text("Rounded Daman"),
                              leading: Radio(
                                value: DamanCharacter.round,
                                groupValue: _damancharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _damancharacter = value;
                                  });
                                },
                              ),
                              trailing: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1547721064-da6cfb341d50"))),
                          ListTile(
                              title: Text("Straight Daman"),
                              leading: Radio(
                                value: DamanCharacter.straight,
                                groupValue: _damancharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _damancharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Choose your Shalwar Design",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Select One",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: const Text(
                                '1 Required',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              backgroundColor: Colors.blue[100],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          ListTile(
                              title: Text("Simple Normal Design"),
                              leading: Radio(
                                value: shalwarCharacter.simple,
                                groupValue: _shalwarcharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _shalwarcharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Trouser Design"),
                              leading: Radio(
                                value: shalwarCharacter.trouser,
                                groupValue: _shalwarcharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _shalwarcharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star)),
                          ListTile(
                              title: Text("Straight Pant Design"),
                              leading: Radio(
                                value: shalwarCharacter.straight,
                                groupValue: _shalwarcharacter,
                                onChanged: (value) {
                                  setState(() {
                                    _shalwarcharacter = value;
                                  });
                                },
                              ),
                              trailing: Icon(Icons.star))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        //  addDataToDatabase();
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Proceed"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(340, 40), primary: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(),
      // backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Customization",
        // style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.check,
            size: 26.0,
          ),
        ),
        SizedBox(width: defaultPadding),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}