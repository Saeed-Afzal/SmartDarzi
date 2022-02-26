// import 'dart:ffi';

// import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/Screens/Component/AvatarWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: UserProfileData(),
    );
  }
}

class UserProfileData extends StatefulWidget {
  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

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

// File _image;
// final picker = ImagePicker();

// Future getImage(BuildContext context) async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     _image = File(pickedFile.path);
//     var base64 = base64Encode(File(pickedFile.path).readAsBytesSync());
//     // var saveFile = FileData(
//     //     isValidityPeriodRequired: false,
//     //     fileData: base64,
//     //     fileName: basename(_image.path),
//     //     mimeType: lookupMimeType(_image.path));

//     ProgressDialog progrssDialog =
//         ProgressDialog(context, isDismissible: false);
//     try {
//       await progrssDialog.show();
//       addProfile.avatar =
//           (await Webservice().postData(FileData.getFile(saveFile))).filePath;

//       await _updateProfile(context);
//       await progrssDialog.hide();
//     } catch (error) {
//       await progrssDialog.hide();
//     }
//   }
// }

class _UserProfileDataState extends State<UserProfileData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height,
                      width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            Color(0xFF73AEF5),
                            Color(0xFF61A4F1),
                            Color(0xFF478DE0),
                            Color(0xFF398AE5),
                          ],
                          // ignore: prefer_const_literals_to_create_immutables
                          stops: [0.1, 0.4, 0.7, 0.9],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Stack(children: [
                              AvatarWidget(
                                  radius: 60, name: snapshot.data['name']),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    AlertDialog(
                                      title: Text(
                                          'Welcome'), // To display the title it is optional
                                      content: Text(
                                          'GeeksforGeeks'), // Message which will be pop up on the screen
                                      // Action widget which will provide the user to acknowledge the choice
                                      actions: [
                                        FlatButton(
                                          // FlatButton widget is used to make a text to work like a button
                                          textColor: Colors.black,
                                          onPressed:
                                              () {}, // function used to perform after pressing the button
                                          child: Text('CANCEL'),
                                        ),
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {},
                                          child: Text('ACCEPT'),
                                        ),
                                      ],
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, top: 0, right: 10, bottom: 0),
                            height: 420,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: size.width,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF7B7B7B),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Name",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit_outlined),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   _volume += 10;
                                                        // });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                          snapshot.data['name'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .blueGrey)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: size.width,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF7B7B7B),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Email",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit_outlined),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   _volume += 10;
                                                        // });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                          snapshot
                                                              .data['email'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .blueGrey)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: size.width,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF7B7B7B),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Password",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit_outlined),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   _volume += 10;
                                                        // });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text("*****",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .blueGrey)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: size.width,
                                            height: 75,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF7B7B7B),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Mobile Number",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit_outlined),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   _volume += 10;
                                                        // });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "03122623413",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
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
                        ],
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [
                    //         Color(0xFF73AEF5),
                    //         Color(0xFF61A4F1),
                    //         Color(0xFF478DE0),
                    //         Color(0xFF398AE5),
                    //       ],
                    //     ),
                    //   ),
                    //   child: Column(
                    //     children: [

                    //       // Row(
                    //       //   mainAxisAlignment: MainAxisAlignment.center,
                    //       //   children: [
                    //       //     Text(
                    //       //       snapshot.data['name'],
                    //       //       style: TextStyle(
                    //       //           fontSize: 32.0,
                    //       //           color: Colors.white,
                    //       //           fontWeight: FontWeight.bold),
                    //       //     ),
                    //       //     GestureDetector(
                    //       //       onTap: () {
                    //       //         _showCupertinoDialog();
                    //       //       },
                    //       //       child: Icon(
                    //       //         Icons.edit,
                    //       //         size: 20,
                    //       //         color: Colors.white,
                    //       //       ),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //       // SizedBox(
                    //       //   height: 20,
                    //       // ),
                    //       // Container(
                    //       //   padding: EdgeInsets.all(12),
                    //       //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //       //   decoration: BoxDecoration(
                    //       //       color: Colors.white,
                    //       //       borderRadius: BorderRadius.circular(8)),
                    //       //   child: Row(
                    //       //     children: [
                    //       //       SizedBox(
                    //       //         width: 5,
                    //       //       ),
                    //       //       Icon(
                    //       //         Icons.email,
                    //       //         color: Colors.blue,
                    //       //       ),
                    //       //       SizedBox(
                    //       //         width: 10,
                    //       //       ),
                    //       //       Text(
                    //       //         snapshot.data['email'],
                    //       //         style: TextStyle(
                    //       //           color: Colors.blue,
                    //       //           fontSize: 22.0,
                    //       //           fontWeight: FontWeight.bold,
                    //       //         ),
                    //       //       )
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    // Container(
                    //   margin: EdgeInsets.all(20),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Text(
                    //         'Location: ',
                    //         style: TextStyle(
                    //           color: Theme.of(context).primaryColor,
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Row(
                    //         children: [
                    //           Text(
                    //             'Karachi, Pakistan',
                    //             style: TextStyle(fontSize: 18),
                    //           ),
                    //           SizedBox(width: 10),
                    //           Icon(Icons.edit),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 20,
                    //       ),
                    //       Center(
                    //         child: Text(
                    //           '-Contact Us-',
                    //           style: TextStyle(
                    //               fontSize: 22,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black),
                    //         ),
                    //       ),
                    //       SizedBox(height: 5),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 8),
                    //             child: CircleAvatar(
                    //                 radius: 20,
                    //                 child: Icon(
                    //                   Icons.facebook_sharp,
                    //                   size: 35,
                    //                 )),
                    //           ),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           CircleAvatar(
                    //             radius: 20,
                    //             child: FaIcon(
                    //               FontAwesomeIcons.whatsapp,
                    //               size: 25,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           CircleAvatar(
                    //             radius: 20,
                    //             child: FaIcon(
                    //               FontAwesomeIcons.instagram,
                    //               size: 25,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              );
            }
            return Center(child: Text('Nothing to show'));
          }
          return Center(child: Text('Nothing to show'));
        });
  }

  void _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Cupertino Dialog'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // _dismissDialog();
                  },
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  // _dismissDialog();
                },
                child: Text('HelloWorld!'),
              )
            ],
          );
        });
  }
}
