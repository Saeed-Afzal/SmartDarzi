import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/order_history_pending.dart';

class OrderHistoryCancelled extends StatefulWidget {
  const OrderHistoryCancelled({Key key}) : super(key: key);

  @override
  State<OrderHistoryCancelled> createState() => _OrderHistoryCancelledState();
}

class _OrderHistoryCancelledState extends State<OrderHistoryCancelled> {
  final Stream<QuerySnapshot> _userOrderStream = FirebaseFirestore.instance
      .collection("allorders")
      .where('uid', isEqualTo: '${auth.currentUser.uid}')
      .where("status", isEqualTo: 'cancelled')
      .snapshots();
  @override
  Widget build(BuildContext context) {
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
                      child: Text('No cancelled products to show'),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${index + 1}'),
                            ],
                          ),
                          trailing: Text(
                            'Cancelled',
                          ),
                          title: Text(
                              '${snapshot.data.docs[index]['productname']}'),
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
