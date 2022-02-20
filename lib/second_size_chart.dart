// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Sizec extends StatefulWidget {
//   @override
//   _SizecState createState() => _SizecState();
// }

// class _SizecState extends State<Sizec> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   addDatatoDatabase() {
//     FirebaseFirestore.instance
//         .collection('user data')
//         .doc(auth.currentUser.uid)
//         .collection('Size Chart Data')
//         .add({
//       'size name': sizeNameController.text,
//       'length': '${lengthController.text}',
//       'chest': '${chestController.text}',
//       'shoulder': '${shoulderController.text}',
//       'sleeve': '${sleeveController.text}',
//       'waist': '${waistController.text}',
//       'bottom': '${bottomController.text}',
//       'size': _dropDownValue
//     });
//   }

//   requiredValidation() {
//     if (waistController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Waist',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (bottomController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Waist',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (sleeveController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Sleeves',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (chestController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Chest',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (waistController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Waist',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (sizeNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Name',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else if (lengthController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Please Enter Length',
//           style: TextStyle(color: Colors.white),
//         ),
//         duration: Duration(seconds: 2),
//       ));
//     } else {
//       addData();
//       addDatatoDatabase();
//       setState(() {
//         dropdownList.add(_dropDownValue);
//       });
//       Navigator.pop(context);
//       sizeNameController.clear();
//       lengthController.clear();
//       waistController.clear();
//       chestController.clear();
//       bottomController.clear();
//       sleeveController.clear();
//       shoulderController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _displayTextInputDialog(context);
//         },
//         child: const Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: const Text('Size Chart'),
//         actions: [
//           Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     waist.clear();
//                     chest.clear();
//                     length.clear();
//                     shoulder.clear();
//                     bottom.clear();
//                     sleeves.clear();
//                     Sizename.clear();
//                     dropdownList.clear();
//                   });
//                 },
//                 child: Icon(
//                   Icons.delete_forever,
//                   size: 26.0,
//                 ),
//               )),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ListView.builder(
//               itemCount: Sizename.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(top: 10),
//                   decoration:
//                       BoxDecoration(border: Border.all(color: Colors.blue)),
//                   child: ExpansionTile(
//                     title: Text(dropdownList[index]),
//                     subtitle: GestureDetector(
//                         onTap: () {
//                           // setState(() {
//                           //   sizeList.removeAt(index);

//                           // });
//                         },
//                         child: Row(
//                           children: [
//                             Text(
//                               Sizename[index],
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )
//                             //   IconButton(onPressed: (){

//                             // //     setState(() {
//                             // //   listname.removeAt(index);

//                             // // });
//                             //   },
//                             //   // icon: Icon(Icons.delete),
//                             //   ),
//                             //   Text("Medium")
//                           ],
//                         )),
//                     children: [
//                       ListTile(
//                         title: Text("Length"),
//                         subtitle: Text(length[index]),
//                         // leading: Icon(Icons.line_weight),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "lenght.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, length, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text("Chest"),
//                         subtitle: Text(chest[index]),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "chest.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, chest, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text("Shoulder"),
//                         subtitle: Text(shoulder[index]),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "shoulder.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, shoulder, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text("Sleeves"),
//                         subtitle: Text(sleeves[index]),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "sleeve.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, sleeves, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text("Waist"),
//                         subtitle: Text(waist[index]),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "waist.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, waist, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text("Bottom"),
//                         subtitle: Text(bottom[index]),
//                         // leading: CircleAvatar(
//                         //   backgroundImage: AssetImage(
//                         //       "bottom.jpg"), // no matter how big it is, it won't overflow
//                         // ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             _displayeditInputDialog(context, bottom, index);
//                           },
//                         ),
//                       ),
//                       ListTile(
//                           title: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                             side: BorderSide(
//                                 width: 3,
//                                 color: Colors
//                                     .transparent), //border width and color
//                             elevation: 3, //elevation of button
//                             shape: RoundedRectangleBorder(
//                                 //to set border radius to button
//                                 borderRadius: BorderRadius.circular(5)),
//                             padding: EdgeInsets.all(20)),
//                         onPressed: () {
//                           setState(() {
//                             chest.removeAt(index);
//                             length.removeAt(index);
//                             shoulder.removeAt(index);
//                             sleeves.removeAt(index);
//                             Sizename.removeAt(index);
//                             waist.removeAt(index);
//                             bottom.removeAt(index);
//                             dropdownList.removeAt(index);
//                           });
//                         },
//                         label: const Text('Delete'),
//                         icon: const Icon(Icons.delete),
//                       )),
//                     ],
//                   ),
//                 );
//                 SizedBox(height: 5);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// // Functionlity

// // Functionlity

// // Functionlity

// // Functionlity
//   TextEditingController sizeNameController = TextEditingController();
//   TextEditingController lengthController = TextEditingController();
//   TextEditingController shoulderController = TextEditingController();
//   TextEditingController chestController = TextEditingController();
//   TextEditingController sleeveController = TextEditingController();
//   TextEditingController waistController = TextEditingController();
//   TextEditingController bottomController = TextEditingController();

//   String _dropDownValue;
//   List dropdownList = [];
//   List Sizename = [];
//   List length = [];
//   List chest = [];
//   List shoulder = [];
//   List sleeves = [];
//   List waist = [];
//   List bottom = [];
//   Map data = {};
//   addData() {
//     setState(() {
//       Sizename.add(sizeNameController.text);
//       length.add(lengthController.text);
//       chest.add(chestController.text);
//       shoulder.add(shoulderController.text);
//       sleeves.add(sleeveController.text);
//       waist.add(waistController.text);
//       bottom.add(bottomController.text);
//     });
//   }

// // Functionality Part
//   Future<void> _displayTextInputDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               'Add New Size',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 32,
//                 color: Colors.blueGrey,
//               ),
//             ),
//             // title: Text('Add New Size'),
//             content: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                           ),
//                         ),
//                       ),
//                       hint: _dropDownValue == null
//                           ? Text('Choose Size')
//                           : Text(
//                               _dropDownValue,
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                       isExpanded: true,
//                       iconSize: 30.0,
//                       style: TextStyle(color: Colors.blue),
//                       items: [
//                         'Extra Small',
//                         'Small',
//                         'Medium',
//                         'Large',
//                         'Extra Large'
//                       ].map(
//                         (val) {
//                           return DropdownMenuItem<String>(
//                             value: val,
//                             child: Text(val),
//                           );
//                         },
//                       ).toList(),
//                       onChanged: (val) {
//                         setState(
//                           () {
//                             _dropDownValue = val;
//                           },
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: sizeNameController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Name"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: lengthController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Length"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: chestController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Chest"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: shoulderController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Shoulder"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: sleeveController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Sleeves"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: waistController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Waist"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: bottomController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black38,
//                             ),
//                           ),
//                           hintText: "Enter Bottom"),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           requiredValidation();
//                         },
//                         child: Text("Add Size"))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   TextEditingController editCont = TextEditingController();

//   Future<void> _displayeditInputDialog(
//       BuildContext context, List listname, num) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Edit Size'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   onChanged: (value) {},
//                   controller: editCont,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.black38,
//                         ),
//                       ),
//                       hintText: "Edit"),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         listname[num] = editCont.text;
//                       });
//                       Navigator.pop(context);
//                       editCont.clear();
//                     },
//                     child: Text("Edit"))
//               ],
//             ),
//           );
//         });
//   }
// }
