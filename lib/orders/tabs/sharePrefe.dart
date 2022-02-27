// <<<<<<< Updated upstream:lib/orders/tabs/sharePrefe.dart
// import 'package:flutter_ecommerce_app/Screens/model/product.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// =======
// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'dart:async';

// import 'package:flutter/material.dart';
// >>>>>>> Stashed changes:lib/sharedpreferences.dart

// class SharedPref {
//   // readObject(String key) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   return json.decode(prefs.getString(key));
//   // }

//   // saveObject(String key, value) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   prefs.setString(key, json.encode(value));
//   // }

//   // read(String key) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   return prefs.getString(key);
//   // }

//   Future saveCustomization(Data data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('CustomizationID', data.guid);
//     await prefs.setBool("isCustomized", data.isCustomized);
//   }

//   // remove(String key) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   prefs.remove(key);
//   // }
// }
