import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/sqflite/excel.dart';
import 'package:flutter_app/test.dart';

//信息平铺页面
class ShowAllStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowAllStudentState();
  }
}

class _ShowAllStudentState extends State<ShowAllStudent> {
  List<String> table = [];

  @override
  void initState() {
    super.initState();
    _getTable();
  }

  _getTable() async {
    table = await Excel.getInstance().getTableNames();
    CommonUtils.log2(table);
    for (String t in table) {
      List<String> column = await Excel.getInstance().getColumnCh(t);
      table = column;

      CommonUtils.log2([t, column]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("列表"),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 900,
            height: 500,

            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20,

                ///横轴间距
                mainAxisSpacing: 1,

                ///纵轴间距
//                 childAspectRatio:1 ,///宽高比
              ),
              children: List<Widget>.generate(
                table.length,
                _widget2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widget(int i) {
    return RaisedButton(
      color: Colors.blue,
      highlightColor: Colors.blue[700],
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Text(table[i]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () => CommonUtils.showToast(context, table[i]),
    );
  }

  Widget _widget2(int i) {
    return Row(children: <Widget>[
      Text("第" + i.toString()),
      Text(table[i]),
    ]);
  }
}
