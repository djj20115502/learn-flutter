import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/sqflite/column.dart' as cc;
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

  ObjectKey key = new ObjectKey(1);
  ListView listView;
  ScrollController controller2;

  @override
  Widget build(BuildContext context) {
    scrollController = new ScrollController();
    controller2 = new ScrollController();
    scrollController.addListener(() => {
          CommonUtils.log(key.runtimeType.toString()),
          controller2.jumpTo(scrollController.offset)
        });

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("列表"),
      ),
      body: Row(children: <Widget>[
        Container(
          width: 50,
          child: ListView.builder(
            controller: controller2,
            itemCount: table.length,
            itemExtent: 50.0,
            //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return Text(index.toString());
            },
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            //横向
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                child: ListView.builder(
                  key: key,
                  controller: scrollController,
                  itemCount: table.length,
                  itemExtent: 50.0,
                  //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return _widget2(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  ScrollController scrollController;

  bool _handleScrollNotification(ScrollNotification notification) {
//    print(StackTrace.current.toString());
    return true;
  }

//cc.Column.getInstance().getChinese(table[i])
  Widget _widget2(int i) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("第" + i.toString()),
        Text(table[i] * 10),
      ],
    );
  }

  Future<String> getName(String name) async {
    String rt = await cc.Column.getInstance().getChinese(name);
  }
}
