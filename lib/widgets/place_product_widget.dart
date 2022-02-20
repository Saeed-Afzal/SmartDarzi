import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/sizechartwithdatabase.dart';

var mySizeValue = '';

class PlaceProductWidget extends StatefulWidget {
  const PlaceProductWidget({Key key}) : super(key: key);

  @override
  State<PlaceProductWidget> createState() => _PlaceProductWidgetState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _PlaceProductWidgetState extends State<PlaceProductWidget> {
  @override
  void initState() {
    super.initState();
    mySizeValue = '';
  }

  var v;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('user data')
      .doc(auth.currentUser.uid)
      .collection('Size Chart Data')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          print("Error");
          return Center(
            child: Text(
              'Error Occured',
            ),
          );
        }
        if (snapshot.hasData) {
          return snapshot.data.docs.length == 0
              ? Center(
                  child: Column(
                    children: [
                      Text('Size is not Provided'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('To add a size click on the below button'),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Sizec()));
                        },
                        child: Text('Get Size'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, index) {
                        return RadioListTile(
                          title:
                              Text('${snapshot.data.docs[index]['size name']}'),
                          value: index,
                          groupValue: v,
                          onChanged: (val) {
                            setState(() {
                              v = val;
                              mySizeValue =
                                  snapshot.data.docs[val]['size name'];
                            });
                          },
                        );
                      }),
                );
        }
        return Center(
          child: Text(
            'Nothing to show',
          ),
        );
      },
    );
  }
}
