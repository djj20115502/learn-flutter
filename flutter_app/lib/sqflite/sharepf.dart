import 'package:flutter_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TestSF {
  Database database;
  test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("key", "我们");
    String name = prefs.getString("key");
    CommonUtils.log("TestSF" + name);
  }
}
