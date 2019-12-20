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
  Map<String, String> columnNameE2C = new Map();

  @override
  void initState() {
    super.initState();
    _getTable();
  }

  _getTable() async {
    List<String> allTable = await Excel.getInstance().getTableNames();
    allTable = await Excel.getInstance().getTableNames();
    CommonUtils.log2(["全部的table", allTable]);
    List<String> column = await Excel.getInstance().getColumnCh(allTable[0]);
    CommonUtils.log2(["第一个", allTable[0], column]);
    for (String v in column) {
      String chineseName = await cc.Column.getInstance().getChinese(v);
      if (chineseName == null) {
        continue;
      }
      columnNameE2C[v] = chineseName;
    }
    allData = await Excel.getInstance().getAllData(allTable[0]);
    CommonUtils.log2(["allData", allData.elementAt(0)]);
    setState(() {});
  }

  List<Map<String, dynamic>> allData = [];

  ObjectKey key = new ObjectKey(1);
  ListView listView;
  ScrollController vSscrollController = new ScrollController();
  ScrollController hSscrollController = new ScrollController();
  ScrollController hController = new ScrollController();
  ScrollController vController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    vSscrollController.addListener(() => {
          CommonUtils.log(key.runtimeType.toString()),
          vController.jumpTo(vSscrollController.offset),
        });
    hSscrollController.addListener(() => {
          hController.jumpTo(hSscrollController.offset),
        });
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("列表"),
      ),
      body: Column(
        children: <Widget>[
          ///顶部的列名显示
          Container(
            height: 50,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: hController,
              itemCount: columnNameE2C.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 90,
                  child: Text(columnNameE2C.values.elementAt(index)),
                );
              },
            ),
          ),

          ///底部内容区域
          Expanded(
            child: Row(
              children: <Widget>[
                ///左边的序号区域
                Container(
                  width: 50,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: vController,
                    itemCount: allData.length,
                    itemExtent: 50.0,
                    //强制高度为50.0
                    itemBuilder: (BuildContext context, int index) {
                      return Text(index.toString());
                    },
                  ),
                ),

                ///右边的可滑动的内容区域
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _handleScrollNotification,
                    //横向
                    child: SingleChildScrollView(
                      controller: hSscrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: 1000,
                        child: ListView.builder(
                          key: key,
                          controller: vSscrollController,
                          itemCount: allData.length,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
//    print(StackTrace.current.toString());
    return true;
  }

//cc.Column.getInstance().getChinese(table[i])
  Widget _widget2(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(allData[index][columnNameE2C.keys.elementAt(0)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(1)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(2)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(3)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(4)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(5)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(6)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(7)].toString()),
        Text(allData[index][columnNameE2C.keys.elementAt(8)].toString()),
      ],
    );
  }
}
