import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Sizec extends StatefulWidget {
  @override
  _SizecState createState() => _SizecState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _SizecState extends State<Sizec> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('user data')
      .doc(auth.currentUser.uid)
      .collection('Size Chart Data')
      .snapshots();
  addDatatoDatabase() {
    FirebaseFirestore.instance
        .collection('user data')
        .doc(auth.currentUser.uid)
        .collection('Size Chart Data')
        .add({
      'size name': sizeNameController.text,
      'length': '${lengthController.text}',
      'chest': '${chestController.text}',
      'shoulder': '${shoulderController.text}',
      'sleeve': '${sleeveController.text}',
      'waist': '${waistController.text}',
      'bottom': '${bottomController.text}',
      'size': _dropDownValue ?? 'Default',
    });
  }

  requiredValidation() {
    if (waistController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Waist',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (bottomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Bottom',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (sleeveController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Sleeves',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (chestController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Chest',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (waistController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Waist',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (sizeNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Name',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else if (lengthController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Enter Length',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
    } else {
      // addData();
      addDatatoDatabase();
      setState(() {
        dropdownList.add(_dropDownValue);
      });
      Navigator.pop(context);
      sizeNameController.clear();
      lengthController.clear();
      waistController.clear();
      chestController.clear();
      bottomController.clear();
      sleeveController.clear();
      shoulderController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Size Chart'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.delete_forever,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return snapshot.data.docs.length == 0
              ? Center(
                  child: Text('Nothing to show'),
                )
              : Container(
                  child: ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return ExpansionTile(
                        title: Text(data['size']),
                        children: [
                          ListTile(
                            title: Text("Size Name"),
                            subtitle: Text(data['size name']),
                          ),
                          ListTile(
                            title: Text("size"),
                            subtitle: Text(data['size']),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Length",
                                          lengthToEditController,
                                          () => document.reference.update({
                                                'length':
                                                    "${lengthToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("Length"),
                              subtitle: Text(data['length']),
                            ),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Chest",
                                          chestToEditController,
                                          () => document.reference.update({
                                                'chest':
                                                    "${chestToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("chest"),
                              subtitle: Text(data['chest']),
                            ),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Bottom",
                                          bottomToEditController,
                                          () => document.reference.update({
                                                'bottom':
                                                    "${bottomToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("Bottom"),
                              subtitle: Text(data['bottom']),
                            ),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Waist",
                                          waistToEditController,
                                          () => document.reference.update({
                                                'waist':
                                                    "${waistToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("Waist"),
                              subtitle: Text(data['waist']),
                            ),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Sleeves",
                                          sleevesToEditController,
                                          () => document.reference.update({
                                                'sleeve':
                                                    "${sleevesToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("sleeves"),
                              subtitle: Text(data['sleeve']),
                            ),
                          ),
                          Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors
                                                .transparent), //border width and color
                                        elevation: 3, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(20)),
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          "Shoulder",
                                          shoulderToEditController,
                                          () => document.reference.update({
                                                'shoulder':
                                                    "${shoulderToEditController.text}"
                                              }));
                                    },
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text("Shoulder"),
                              subtitle: Text(data['shoulder']),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.86,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors
                                              .transparent), //border width and color
                                      elevation: 3, //elevation of button
                                      shape: RoundedRectangleBorder(
                                          //to set border radius to button
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.all(20)),
                                  onPressed: () {
                                    document.reference.delete();
                                  },
                                  label: const Text('Delete'),
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }).toList(),
                  ),
                );
        },
      ),
    );
  }

// Functionlity
  TextEditingController sizeNameController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController chestController = TextEditingController();
  TextEditingController sleeveController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController bottomController = TextEditingController();

  String _dropDownValue;
  List dropdownList = [];

// Functionality Part
// Add Data
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add New Size',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.blueGrey,
              ),
            ),
            // title: Text('Add New Size'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      hint: _dropDownValue == null
                          ? Text('Choose Size')
                          : Text(
                              _dropDownValue,
                              style: TextStyle(color: Colors.blue),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: [
                        'Extra Small',
                        'Small',
                        'Medium',
                        'Large',
                        'Extra Large'
                      ].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: sizeNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Name"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: lengthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Length"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: chestController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Chest"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: shoulderController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Shoulder"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: sleeveController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Sleeves"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: waistController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Waist"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: bottomController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          hintText: "Enter Bottom"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          requiredValidation();
                        },
                        child: Text("Add Size"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  TextEditingController editCont = TextEditingController();
  // Edit Functionaliy
//  Edit Dialog
  void showEditDialog(
    BuildContext,
    title,
    controll,
    void callb(),
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit $title'),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controll,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        label: Text('Enter $title'),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        side: BorderSide(
                            width: 3,
                            color: Colors.transparent), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(20)),
                    onPressed: () {
                      callb();
                      Navigator.pop(context);
                      lengthToEditController.clear();
                      chestToEditController.clear();
                      shoulderToEditController.clear();
                      sleevesToEditController.clear();
                      waistToEditController.clear();
                      bottomToEditController.clear();
                    },
                    label: const Text('Edit'),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController lengthToEditController = TextEditingController();
  TextEditingController chestToEditController = TextEditingController();
  TextEditingController shoulderToEditController = TextEditingController();
  TextEditingController sleevesToEditController = TextEditingController();
  TextEditingController waistToEditController = TextEditingController();
  TextEditingController bottomToEditController = TextEditingController();
}
