import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/sqflite/excel.dart';

import '../constant.dart';

class Read extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ReadState();
  }
}

class _ReadState extends State<Read> {
  Excel excel;
  List<String> tables = new List();
  @override
  initState() {
    super.initState();
    excel = new Excel();
    excel.getTableNames().then((m) => setState(() {
          tables = m;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("保存的表")),
      floatingActionButton: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            CommonUtils.log("_counter");
          }),
      body: ListView.builder(
        itemCount: tables.length,
        itemBuilder: (context, index) => ListTile(
          title: Text("${index+1}  ${tables[index]}"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
