import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../test.dart';

class WarpDemo extends StatefulWidget {
    createState() => _WarpDemoState();
}

class _WarpDemoState extends State<WarpDemo> {
  List<Widget> list; //声明一个list数组

  @override
  //初始化状态，给list添加值，这时候调用了一个自定义方法`buildAddButton`
  void initState() {
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }

  @override
  Widget build(BuildContext context) {
    //得到屏幕的高度和宽度，用来设置Container的宽和高
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Wrap流式布局'),
        ),
        body: Center(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: width,
              height: height / 2,
              color: Colors.grey,
              child: Wrap(
                //流式布局，
                children: list,
                spacing: 26.0, //设置间距
              ),
            ),
          ),
        ));
  }

  Widget buildAddButton() {
    //返回一个手势Widget，只用用于显示事件
    return GestureDetector(
      onTap: () {
        if (list.length < 9) {
          setState(() {
            list.insert(list.length - 1, buildPhoto());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.black54,
          child: RaisedButton(onPressed: () {
             setState(() {
            list.insert(list.length - 1, buildPhoto());
             });
          },)
        ),
      ),
    );
  }

  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        color: Colors.amber,
        child: Center(
          child: Image.network(Test.getTestImage()),
        ),
      ),
    );
  }
}
