import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../test.dart';

class ListLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> show = List<String>.generate(1000, (i) => "test $i");
    return Scaffold(
      appBar: AppBar(title: Text("ListLayoutTestRoute")),
      body: ListView.builder(
        itemCount: show.length,
        itemBuilder: (context, index) => ListTile(
              title: Text("${show[index]}"),
              onTap: () =>
                  _navigateToXiaoJieJie(context, index, "${show[index]}"),
            ),
      ),
    );
  }

  _navigateToXiaoJieJie(BuildContext context, int index, String data) async {
    //async是启用异步方法
    String result;
    CommonUtils.log("index:" + index.toString());
    if (index % 2 == 0) {
      result = await Navigator.push(
          //等待
          context,
          MaterialPageRoute(builder: (context) => Detail(title0: data)));
    } else {
      var t2 = await Navigator.of(context)
          .pushNamed(Router.R_ListDetail, arguments: data);
      result = t2.toString();
      CommonUtils.log("t2 " + t2.toString());
    }

    Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
  }
}

class Detail extends StatelessWidget {
  final StringBuffer title = StringBuffer();
  Detail({Key key, String title0}) : super(key: key) {
    title.write(title0);
  }

  @override
  Widget build(BuildContext context) {
    var a = ModalRoute.of(context).settings.arguments;
    CommonUtils.log("title :" + a.toString());

    if (a != null) {
      title.write(a.toString());
    }

    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: RaisedButton(
        onPressed: () {
          Navigator.pop(context, title);
        },
        child: Text("$title"),
      ),
      // body: Text("$title",textAlign: TextAlign.end),
    );
  }
}
