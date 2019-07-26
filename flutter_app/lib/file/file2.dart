import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
    _just_test();
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
    if (result != null) {
      CommonUtils.log("result keys :" + result.keys.length.toString());
    }
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
