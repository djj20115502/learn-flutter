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
    _getTalbe();
  }

  _getTalbe() async {
    List<String> names = await new Excel().getColumn("");
    CommonUtils.log2(names);
    table = await new Excel().getTableNames();
    CommonUtils.log2(table);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("列表"),
//        actions: <Widget>[
//           Tooltip(
//              message: "根据名称收索",
//              child: IconButton(
//                  icon: Icon(Icons.search),
//                  onPressed: () {
//                    showSearch(
//                        context: context, delegate: _searchBarDelegate(shows));
//                  }))
//        ],
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,

          ///横轴间距
          mainAxisSpacing: 20,

          ///纵轴间距
          // childAspectRatio:1 ,///宽高比
        ),
        children: List<Widget>.generate(
          table.length,
          (i) => RaisedButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text(table[i]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () => CommonUtils.showToast(context, table[i]),
          ),
        ),
      ),
    );
  }
}
