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
//    return   new Scaffold(
//      appBar: new AppBar(
//        title: new Text("LinearLayout Example"),
//      ),
//      body: Scrollbar(
//        child: SingleChildScrollView(
//          scrollDirection: Axis.horizontal,
//          child: Container(
//            color: Colors.yellowAccent,
//            child: new Row(
//              //Column
//              mainAxisSize: MainAxisSize.min,
//              //wrap_content ,不加的话默认为match_parent（MainAxisSize.max）
////              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.start,
//              //start==left,center==center,end==right ,
//              // spaceEvenly==等比例居中，4个间距一样大（weight=1),spaceAround=等比例居中，6个间距一样大,spaceBetween=中间居中，两边顶边
//              children: [
//                Container(
//                  child: new Icon(
//                    Icons.access_time,
//                    size: 50.0,
//                  ),
//                  color: Colors.red,
//                ),
//                Container(
//                  child: new Icon(
//                    Icons.pie_chart,
//                    size: 370.0,
//                  ),
//                  color: Colors.blue,
//                ),
//                Container(
//                  child: new Icon(
//                    Icons.email,
//                    size: 50.0,
//                  ),
//                  color: Colors.green,
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    ) ;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("列表"),
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
              //              child: ListView.builder(
//                  itemCount: table.length,
//                  itemExtent: 50.0, //强制高度为50.0
//                  itemBuilder: (BuildContext context, int index) {
//                    return _widget2(index);
//                  })),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _widget223()),
        )));
  }

  Widget _widget2(int i) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("第" + i.toString()),
          Text(table[i] * 5),
        ]);
  }

  List<Widget> _widget223() {
    List<Widget> list = new List();
    for (int i = 0; i < table.length; i++) {
      list.add(_widget2(i));
    }
    return list;
  }

  Widget _widget24() {
    return Container(
        color: Colors.yellowAccent,
        child: new Row(
            //Column
            mainAxisSize: MainAxisSize.min,
            //wrap_content ,不加的话默认为match_parent（MainAxisSize.max）
//              mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            //start==left,center==center,end==right ,
            // spaceEvenly==等比例居中，4个间距一样大（weight=1),spaceAround=等比例居中，6个间距一样大,spaceBetween=中间居中，两边顶边
            children: [
              Container(
                child: new Icon(
                  Icons.access_time,
                  size: 50.0,
                ),
                color: Colors.red,
              ),
              Container(
                child: new Icon(
                  Icons.pie_chart,
                  size: 370.0,
                ),
                color: Colors.blue,
              ),
              Container(
                child: new Icon(
                  Icons.email,
                  size: 50.0,
                ),
                color: Colors.green,
              ),
            ]));
  }
}
