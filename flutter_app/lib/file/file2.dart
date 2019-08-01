import 'dart:isolate';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/sqflite/excel.dart';

import '../constant.dart';

class FileList2 extends StatefulWidget {
  createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<FileList2> {
  static const platform = const MethodChannel('samples.flutter.io');

  List<String> show = new List();
  String title = "FileList";
  String batteryLevel = "";

  @override
  void initState() {
    super.initState();
    CommonUtils.log(
        "onValue1" + new DateTime.now().millisecondsSinceEpoch.toString());
    _getxls();
    // _just_test();
  }

  Future<Null> _just_test() async {
    String result;
    try {
      result = await platform.invokeMethod('just_test');
    } on PlatformException catch (e) {
      result = e.message;
    }
    CommonUtils.log(" just_test result:" + result);
    setState(() {
      title = title + result;
    });
  }

  Future<Null> _getxls() async {
    Map<dynamic, dynamic> result;
    try {
      result = await platform.invokeMethod('xls');
    } on PlatformException catch (e) {
      CommonUtils.log("result:" + e.message);
    }
    if (result == null) {
      return;
    }
    CommonUtils.log("result keys :" +
        result.runtimeType.toString() +
        result.keys.length.toString());

    for (var i in result.keys.toList()) {
      CommonUtils.log("result keys " + i.runtimeType.toString() + i.toString());
      CommonUtils.log("result runtimeType " + result[i].runtimeType.toString());
      // whilelist(result[i]);
      try {
        List<List<String>> a = result[i] as List<List<String>>;
        CommonUtils.log2(["aaaa", a]);
      } catch (e) {
        CommonUtils.log2(["_getxls", e]);
      }
      writeToDb(i.toString(), result[i]);
    }

    CommonUtils.log("result keys :" + result.keys.length.toString());
  }

  writeToDb(String tableName, Object list) async {
    if ("勿动".compareTo(tableName) == 0) {
      return;
    }
    if (list is! List) {
      return;
    }
    List L1 = list as List;
    if (L1 == null || L1.length < 1 || L1[0] is! List) {
      return;
    }

    try {
      List<String> columnNames = new List<String>.from(L1[0]);
      List<List<String>> data = new List();
      for (int i = 1; i < L1.length; i++) {
        data.add(new List<String>.from(L1[i]));
      }
      await new Excel()
          .insertData(tableName, columnNames, data, needToEN: true);
    } catch (e) {
      CommonUtils.log2(["writeToDb", e]);
    }
  }

  whilelist(Object data) {
    CommonUtils.log("whilelist  " +
        data?.runtimeType.toString() +
        data?.toString().substring(0, min(data?.toString().length, 10)));
    if (data == null) {
      return;
    }
    if (!(data is List)) {
      return;
    }
    List<dynamic> list = data as List;
    CommonUtils.log("whilelist  " + list.length.toString());
    if (list.length == 0) {
      CommonUtils.log("whilelist  list.length=0");
      return;
    }
    whilelist(list[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$title")),
      floatingActionButton: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            CommonUtils.log("_counter");
          }),
      body: ListView.builder(
        itemCount: show.length,
        itemBuilder: (context, index) => ListTile(
          title: Text("${show[index]}"),
        ),
      ),
    );
  }
}
