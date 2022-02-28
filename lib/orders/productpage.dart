import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/AddressScreens/AddressList.dart';
import 'package:flutter_ecommerce_app/Screens/Component/Card_counter.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';
import 'package:flutter_ecommerce_app/Screens/model/product.dart';
import 'package:flutter_ecommerce_app/orders/tabs/customiseScreen.dart';
import 'package:flutter_ecommerce_app/widgets/place_product_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter/cupertino.dart';
//import 'package:geolocator/geolocator.dart';

enum FabricCharacter { fabric, nofabric }
String dropdownValue = 'One';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, @required this.productData}) : super(key: key);
  final ProductData productData;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //Position _currentPosition;
  String date = "";
  DateTime selectedDate = DateTime.now();

  FabricCharacter _character = FabricCharacter.fabric;

  int selectedRadio = 0;
  int _currentImage = 0;
  var userCus = null;
  var fabricData = 'I have fabric';
  var deliveryData;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.productData.images.length; i++) {
      list.add(
          i == _currentImage ? buildIndicator(true) : buildIndicator(false));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 20.0 : 8.0,
      decoration: BoxDecoration(
        gradient: isActive ? kGradient : kGradientGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

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

  // TextEditingController addressController = TextEditingController();

  // File pickedImageData;
  // String imageUrl = 'No image to show';

  // String sizeTypeIdFirstDropdown = '2';
  // String sizeIdOfFirstDropdown;
  // String sizeTypeIdSecondDropdown;
  // String sizeIdOfSecondDropown;
  // bool _isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  onBackPressed() async {
    try {
      await firestoreInstance.collection('customize').doc(userCus).delete();
    } catch (e) {
      print(e);
    }
  }

  addUserProductData() async {
    try {
      var sizeData = await firestoreInstance
          .collection('user data')
          .doc(auth.currentUser.uid)
          .collection('Size Chart Data')
          .doc('PUZM5qroLUR8nfQxdFY2')
          .get();
      var customizeData =
          await firestoreInstance.collection('customize').doc(userCus).get();
      if (customizeData.data() == null) {
        firestoreInstance
            .collection('allorders')
            .doc('${auth.currentUser.uid}${DateTime.now().toString()}')
            .set({
          'fabric': fabricData,
          'uid': auth.currentUser.uid,
          'productname': widget.productData.name,
          'productprice': widget.productData.price,
          'productimage': widget.productData.images,
          ...sizeData.data(),
          'status': 'pending',
          'deliverydate': deliveryData,
        });
      } else {
        firestoreInstance
            .collection('allorders')
            .doc('${auth.currentUser.uid}${DateTime.now().toString()}')
            .set({
          'fabric': fabricData,
          ...sizeData.data(),
          ...customizeData.data(),
          'uid': auth.currentUser.uid,
          'productimage': widget.productData.images,
          'status': 'pending',
          'deliverydate': deliveryData,
        });
      }
      // print(customizeData.data());

    } catch (e) {
      print(e);
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   addressController.dispose();
  //   mySizeValue = '';
  // }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pickImageGallery,
      //   child: Icon(Icons.link_outlined),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                height: 360,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          // clipBehavior: Clip.none,
                          // alignment: Alignment.center,
                          children: [
                            Container(
                              // color: Color(0xFFF8F8F8),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 25),
                                    child: PageView(
                                      physics: BouncingScrollPhysics(),
                                      onPageChanged: (int page) {
                                        setState(() {
                                          _currentImage = page;
                                        });
                                      },
                                      children:
                                          widget.productData.images.map((path) {
                                        return Center(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: size.height * 0.40,
                                              margin:
                                                  EdgeInsets.only(right: 100),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/claZwr.gif',
                                                image: path,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  widget.productData.images.length > 1
                                      ? Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: buildPageIndicator(),
                                            ),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                            // Positioned(
                            //   bottom: -50,
                            //   child: CartCounter(),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          "Rs: ${widget.productData.price}",
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
                              "${widget.productData.name}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.85, 0),
                          child: Text(
                            'Fabric Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('I have fabric'),
                            leading: Radio<FabricCharacter>(
                              value: FabricCharacter.fabric,
                              groupValue: _character,
                              onChanged: (FabricCharacter value) {
                                setState(() {
                                  fabricData = 'I have fabric';

                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('I dont have fabric'),
                            leading: Radio<FabricCharacter>(
                              value: FabricCharacter.nofabric,
                              groupValue: _character,
                              onChanged: (FabricCharacter value) {
                                setState(() {
                                  fabricData = 'I dont have fabric';
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    height: 180,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.85, 0),
                          child: Text(
                            'Size Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('Pre Made Size'),
                            leading: Radio<FabricCharacter>(
                              value: FabricCharacter.fabric,
                              groupValue: _character,
                              onChanged: (FabricCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('Custom Size'),
                            leading: Radio<FabricCharacter>(
                              value: FabricCharacter.nofabric,
                              groupValue: _character,
                              onChanged: (FabricCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                        // DropdownButton<String>(
                        //   value: dropdownValue,
                        //   icon: const Icon(Icons.arrow_downward),
                        //   elevation: 16,
                        //   style: const TextStyle(color: Colors.deepPurple),
                        //   underline: Container(
                        //     height: 2,
                        //     color: Colors.deepPurpleAccent,
                        //   ),
                        //   onChanged: (String newValue) {
                        //     setState(() {
                        //       dropdownValue = newValue;
                        //     });
                        //   },
                        //   items: <String>['One', 'Two', 'Free', 'Four']
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.85, 0),
                          child: Text(
                            'Delivery Date',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text("Choose Date"),
                        ),
                        Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.85, 0),
                          child: Text(
                            'Delivery Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // OutlinedButton(
                        //   onPressed: () {
                        //     debugPrint('Received click');
                        //   },
                        //   child: const Text('Click Me'),
                        // ),
                        // if (_currentPosition != null)
                        //   Text(
                        //       "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                        ElevatedButton(
                          // style: style,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressList()),
                            );
                            //  _getCurrentLocation();
                          },
                          child: const Text('Select Address'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 180,
                          margin: EdgeInsets.all(10),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/sideImage.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop),
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Set rounded corner radius
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Text(
                                "For More Customization",
                                style: TextStyle(
                                    color: HexColor("#0071bc").withOpacity(0.8),
                                    fontSize: 28.0,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OutlinedButton(
                                  child: Text("Click Here".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#0071bc")),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                              side: BorderSide(
                                                  color:
                                                      HexColor("#0071bc"))))),
                                  onPressed: () async {
                                    userCus = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => CustomiseScreen(
                                                  imageUrl: widget
                                                      .productData.images[0],
                                                  name: widget.productData.name,
                                                  price:
                                                      widget.productData.price,
                                                )));
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(Icons.comment,
                                    size: 26.0, color: Colors.blue),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              hintText: "Breif Your Design Here",
                              hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      new Radius.circular(5.0))),
                              labelStyle: TextStyle(color: primaryColor)),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                          // controller: host,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Empty value";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                            minLines:
                                6, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(Icons.comment,
                                    size: 26.0, color: Colors.blue),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: addUserProductData, child: Text("CHECKOUT")),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          onBackPressed();
          Navigator.pop(context);
        },
      ),
      // backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Place Order",
        // style: TextStyle(color: Colors.black),
      ),
      actions: [
        // FavBtn(radius: 20),
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
        deliveryData =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }

  //   _getCurrentLocation() {
  //   Geolocator
  //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //     .then((Position position) {
  //       setState(() {
  //         _currentPosition = position;
  //       });
  //     }).catchError((e) {
  //       print(e);
  //     });
  // }
}
