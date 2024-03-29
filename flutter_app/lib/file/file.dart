import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../test.dart';

class FileList extends StatefulWidget {
  createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<StatefulWidget> {
  List<String> show = new List();
  String title = "FileList";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localPath();
     _readCounter().then((onValue) {
      _counter = onValue;
      setState(() {
        title = "FileList" + _counter.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$title")),
      floatingActionButton: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _incrementCounter();
            CommonUtils.log("_counter" + _counter.toString());
          }),
      body: ListView.builder(
        itemCount: show.length,
        itemBuilder: (context, index) => ListTile(
          title: Text("${show[index]}"),
        ),
      ),
    );
  }

  localPath() async {
    try {
      var tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      show.add('临时目录: ' + tempPath);
      show.add('文档目录: ' + appDocPath);
      print('临时目录: ' + tempPath);
      print('文档目录: ' + appDocPath);
      var all = await getExternalStorageDirectory();
      print('sd: ' + all.path);
      show.add('外部目录: ' + all.path);
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  int _counter = 0;

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getExternalStorageDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      CommonUtils.log("contents--------------" + contents);
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
      title = "FileList" + _counter.toString();
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }
}
