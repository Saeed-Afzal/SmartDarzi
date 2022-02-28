import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';

class OrderHistoryPending extends StatefulWidget {
  const OrderHistoryPending({Key key}) : super(key: key);

  @override
  State<OrderHistoryPending> createState() => _OrderHistoryPendingState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _OrderHistoryPendingState extends State<OrderHistoryPending> {
  final Stream<QuerySnapshot> _userOrderStream = FirebaseFirestore.instance
      .collection("allorders")
      .where('uid', isEqualTo: '${auth.currentUser.uid}')
      .where("status", isEqualTo: 'pending')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: _userOrderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return snapshot.data.docs.length == 0
                  ? Center(
                      child: Text('No pending request to show'),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  height: size.height * 0.30,
                                  // margin: EdgeInsets.only(right: 50),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: imageLoading,
                                    image: snapshot.data.docs[index]
                                        ['productimage'][0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Divider(
                                height: 5,
                                thickness: 2,
                                indent: 0,
                                endIndent: 0,
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          dateTimeFormat
                                              .format(DateTime.parse(snapshot
                                                  .data.docs[index]['date']))
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                         "Product Name " +
                                              snapshot.data.docs[index]
                                                  ['productname'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                       "Total: Rs. " +
                                              snapshot.data.docs[index]
                                                  ['price'],
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
                                    child: Chip(
                                      label: const Text(
                                        'Completed',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14),
                                      ),
                                      backgroundColor: Colors.blue[100],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      });
            } else {
              return Center(
                child: Text('Nothing to show'),
              );
            }
          }
          return Center(
            child: Text('Error'),
          );
        });
  }
}
