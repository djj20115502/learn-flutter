import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../test.dart';

class KeepAliveDemo extends StatefulWidget {
    createState() => _KeepAliveDemoState();
}

/*
with是dart的关键字，意思是混入的意思，
就是说可以将一个或者多个类的功能添加到自己的类无需继承这些类，
避免多重继承导致的问题。
SingleTickerProviderStateMixin 主要是我们初始化TabController时，
需要用到vsync ，垂直属性，然后传递this
*/
class _KeepAliveDemoState extends State<KeepAliveDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  //重写被释放的方法，只释放TabController
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Keep Alive Demo'),
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            )),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            test2(title: "A"),
            test2(title: "B"),
            test2(title: "C"),
          ],
        ));
  }
}

class test2 extends StatefulWidget {
  final String title;
  test2({Key key, this.title}) : super(key: key);

  _test2State createState() => _test2State();
}

class _test2State extends State<test2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    CommonUtils.log("initState " + widget.title + "___" + hashCode.toString());

    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    CommonUtils.log("dispose " + widget.title + "___" + hashCode.toString());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('_test2State'),
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: Icon(Icons.directions_subway)),
                Tab(icon: Icon(Icons.directions_subway)),
                Tab(icon: Icon(Icons.directions_subway)),
              ],
            )),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            MyHomePage(title: widget.title + "11"),
            MyHomePage(title: widget.title + "22"),
            MyHomePage(title: widget.title + "33"),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => widget.title.contains("A");
}

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//混入AutomaticKeepAliveClientMixin，这是保持状态的关键
//然后重写wantKeppAlive 的值为true。
class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;
  //重写keepAlive 为ture ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive =>  widget.title.contains("B");
  @override
  void initState() {
    super.initState();
    CommonUtils.log("initState " + widget.title + "___" + hashCode.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CommonUtils.log(
        "didChangeDependencies " + widget.title + "___" + hashCode.toString());
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    CommonUtils.log(
        "didUpdateWidget " + widget.title + "___" + hashCode.toString());
  }

  @override
  void dispose() {
    super.dispose();
    CommonUtils.log("dispose " + widget.title + "___" + hashCode.toString());
  }

  @override
  void deactivate() {
    super.deactivate();
    CommonUtils.log("deactivate " + widget.title + "___" + hashCode.toString());
  }

  //声明一个内部方法，用来点击按钮后增加数量
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonUtils.log("build " + widget.title + "___" + hashCode.toString());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点一下加1，点一下加1:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      //增加一个悬浮按钮，点击时触犯_incrementCounter方法
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
