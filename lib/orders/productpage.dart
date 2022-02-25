import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/widgets/place_product_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ProductPage extends StatefulWidget {
  int index;
  List productData;
  ProductPage({Key key, @required this.productData, @required this.index})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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

  void _pickImageGallery() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        pickedImageData = pickedImageFile;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Your image is selected',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    }
    // Navigator.pop(context);
  }

  // void _remove() {
  //   setState(() {
  //     _pickedImage = null;
  //   });
  //   Navigator.pop(context);
  // }

  addDataToDatabase() async {
    if (sizeTypeIdFirstDropdown == '2') {
      if (mySizeValue == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please select Your size',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ));
        return;
      }
    }
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please enter your address',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (sizeTypeIdFirstDropdown == '1') {
      if (sizeIdOfSecondDropown == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please enter your size',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ));
        return;
      }
    }
    setState(() {
      _isLoading = true;
    });
    try {
      String time = DateTime.now().toString();
      var name = await firestoreInstance
          .collection('userinfo')
          .doc(auth.currentUser.uid)
          .get();
      if ((pickedImageData.toString().contains('/'))) {
        var abc;
        final ref = FirebaseStorage.instance
            .ref()
            .child('usersImages')
            .child(name['name'] + '.jpg');
        await ref.putFile(pickedImageData);
        abc = await ref.getDownloadURL();
        setState(() {
          imageUrl = abc;
        });
      }
      print('Outside of image url');
      await firestoreInstance
          .collection('userorder')
          .doc(auth.currentUser.uid)
          .collection('product')
          .add({
        'user name': name['name'],
        'user id': auth.currentUser.uid,
        'order placed': time,
        'product name': widget.productData[widget.index]['name'],
        'size type': sizeTypeIdFirstDropdown == '1'
            ? sizes[int.parse(sizeIdOfSecondDropown) - 1]['Label']
            : '',
        'size name': mySizeValue,
        'location': addressController.text.toString(),
        'uploaded size': imageUrl,
        'isPending': true,
        'isCompleted': false,
        'isCancelled': false,
      });
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      print('$e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageGallery,
        child: Icon(Icons.link_outlined),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(10),
                        // topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.network(
                          '${widget.productData[widget.index]['image'][0]}',
                          height: 200,
                          fit: BoxFit.fill,
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Rs: ${widget.productData[widget.index]['price']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.productData[widget.index]['name']}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Icon(
                              //   Icons.favorite_outline,
                              // ),
                              Card(
                                margin: EdgeInsets.only(right: 12),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.favorite_outline,
                                    color: Colors.black,
                                    size: 19,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 100),
                  // height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      // bottomLeft: Radius.circular(15),
                      // bottomRight: Radius.circular(15)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Description ",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Best Winter Dresses Collections",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        //First DropDown
                        FormHelper.dropDownWidgetWithLabel(
                          context,
                          "Size Type",
                          "Select Size Type here",
                          this.sizeTypeIdFirstDropdown,
                          this.sizeType,
                          (onChangedVal) {
                            sizeTypeIdFirstDropdown = onChangedVal;
                            sizeName = sizes
                                .where((sizeItem) =>
                                    sizeItem["ParentId"].toString() ==
                                    onChangedVal.toString())
                                .toList();
                          },
                          (onValidateVal) {
                            if (onValidateVal == null) {
                              return "Please select size type";
                            }
                            return null;
                          },
                          labelFontSize: 16,
                          borderColor: Theme.of(context).primaryColor,
                          borderFocusColor: Theme.of(context).primaryColor,
                          borderRadius: 10,
                          optionValue: "id",
                          optionLabel: "label",
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Second DropDown
                        sizeTypeIdFirstDropdown == '1'
                            ? FormHelper.dropDownWidgetWithLabel(
                                context,
                                "Size Name",
                                "Select Size",
                                this.sizeIdOfSecondDropown,
                                this.sizeName,
                                (onChangedVal) {
                                  this.sizeIdOfSecondDropown = onChangedVal;
                                },
                                (onValidate) {
                                  return null;
                                },
                                labelFontSize: 16,
                                borderColor: Theme.of(context).primaryColor,
                                borderFocusColor:
                                    Theme.of(context).primaryColor,
                                borderRadius: 10,
                                optionValue: "ID",
                                optionLabel: "Label",
                              )
                            : Center(
                                child: PlaceProductWidget(),
                                // child: TextButton(
                                //   onPressed: () {
                                //     Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //             builder: (ctx) => Sizec()));
                                //   },
                                //   child: Text('Get Size'),
                                // ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        // Address Text Field

                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            constraints: BoxConstraints(minHeight: 55),
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                hintText: 'Your Address',
                                label: Text('Your address'),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Order Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              addDataToDatabase();
                            },
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Order Now"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(340, 40),
                                primary: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
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
}
