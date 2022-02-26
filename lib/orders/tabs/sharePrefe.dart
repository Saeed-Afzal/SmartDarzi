import 'package:flutter_ecommerce_app/Screens/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
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

  Future saveCustomization(Data data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('CustomizationID', data.guid);
    await prefs.setBool("isCustomized", data.isCustomized);
  }

  // remove(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key);
  // }
}
