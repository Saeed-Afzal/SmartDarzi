import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class SharedPref<T> {
  // readObject(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return json.decode(prefs.getString(key));
  // }

  // saveObject(String key, value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key, json.encode(value));
  // }

  // read(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }

  save(String key, value) async {
    var sharedPreferences = SharedPreferences;
    final prefs = await sharedPreferences.getInstance();
    prefs.setString(key, (value));
  }

  // remove(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key);
  // }
}