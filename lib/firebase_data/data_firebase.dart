import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseManager {
  String gender;
  String itemType;
  DatabaseManager({@required this.gender, @required this.itemType});
  List uData = [];

  Future<List> getProductsData() async {
    try {
      var productData;
      productData = await FirebaseFirestore.instance
          .collection('products')
          .doc('$gender')
          .collection('$itemType')
          .get()
          .then((QuerySnapshot element) {
        if (element != null) {
          element.docs.forEach((data) {
            var a = data.data() as Map;
            uData.add({
              'id': a['id'],
              'name': a['name'],
              'image': a['image'],
              'price': a['price']
            });
          });
        } else {
          return uData;
        }
      });
      return uData;
    } catch (e) {
      print('some Error');
      return null;
    }
  }
}
