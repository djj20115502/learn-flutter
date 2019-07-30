import 'dart:isolate';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      whilelist(result[i]);
    }

    CommonUtils.log("result keys :" + result.keys.length.toString());
  }

  whilelist(Object data) {
    var receivePort = new ReceivePort();
    Isolate.spawn(echo, receivePort.sendPort);
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

  echo(SendPort sendPort) async {
    // 实例化一个ReceivePort 以接收消息
    var port = new ReceivePort();

    // 把它的sendPort发送给宿主isolate，以便宿主可以给它发送消息
    sendPort.send(port.sendPort);

    // 监听消息
    await for (var msg in port) {
      var data = msg[0];
      SendPort replyTo = msg[1];
      replyTo.send(data);
      if (data == "bar") port.close();
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
