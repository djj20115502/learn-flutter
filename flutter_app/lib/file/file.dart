import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../constant.dart';

class FileList extends StatefulWidget {
  createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<StatefulWidget> {
  List<String> show = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localPath();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text("FileList")),
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
}
