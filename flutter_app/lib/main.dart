import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/file/read.dart';
import 'package:flutter_app/net/test.dart';
import 'package:flutter_app/step2/custome_router.dart';
import 'package:flutter_app/step2/keeplive.dart' as keeplive;
import 'package:flutter_app/step2/navgater.dart';
import 'package:flutter_app/step2/searchbar.dart';
import 'package:flutter_app/test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc.dart';
import 'bloc/inheritedWidget.dart';
import 'constant.dart';
import 'file/file.dart';
import 'file/file2.dart';
import 'kcwc/shopcar/shopcar.dart';
import 'kcwc/sliverDemoPage.dart';
import 'step2/gesturedetector.dart';

void collectLog(String line) {
  print("DJJTEST error" + line);
  //收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  print("DJJTEST reportErrorAndLog");
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  print("DJJTEST makeDetails ");

  // 构建错误信息
}

void main() {
  runApp(MyApp());
  // TestIsolate.testIsolate();
  // new Db().initDb();
  // TestSF().test();
  // Excel.test();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  StatelessElement a;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Just test'),
      routes: Router.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375)..init(context);

    List<ItemBean> shows = [
      ItemBean(
          title: "导航到新路由",
          onPress: () => Navigator.of(context)
              .pushNamed(Router.R_NewRoute, arguments: "h22222i")),
      ItemBean(
          title: "buttons",
          onPress: () => Navigator.of(context)
              .pushNamed(Router.R_Buttons, arguments: "buttons")),
      ItemBean(
          title: "flex",
          onPress: () =>
              Navigator.of(context).pushNamed(Router.R_FlexLayoutTestRoute)),
      ItemBean(
          title: "ListLayout",
          onPress: () =>
              Navigator.of(context).pushNamed(Router.R_ListLayoutTestRoute)),
      ItemBean(
          title: "GridRoute",
          onPress: () => Navigator.of(context).pushNamed(Router.R_GridRoute)),
      ItemBean(
          title: "不同的路由动画",
          onPress: () {
            Test.testCount++;
            Navigator.push(context, new CustomRoute(BottomNavgater()));
          }),
      ItemBean(
          title: "live",
          onPress: () {
            Navigator.push(context, CustomRoute(keeplive.KeepAliveDemo()));
          }),
      ItemBean(
          title: "SearchBarDemo",
          onPress: () {
            Navigator.push(context, CustomRoute(SearchBarDemo()));
          }),
      ItemBean(
          title: "WarpDemo",
          onPress: () {
            Navigator.push(context, CustomRoute(WarpDemo()));
          }),
      ItemBean(
          title: "FileList",
          onPress: () {
            Navigator.push(context, CustomRoute(FileList()));
          }),
      ItemBean(
          title: "读取表格FileList2",
          onPress: () {
            Navigator.push(context, CustomRoute(FileList2()));
          }),
      ItemBean(
          title: "读数据库",
          message: "读取所有的数据库",
          onPress: () {
            Navigator.push(context, CustomRoute(Read()));
          }),
      ItemBean(
          title: "网络访问",
          onPress: () {
            Navigator.push(context, CustomRoute(NetShowView()));
          }),
      ItemBean(
          title: "商铺店内车",
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ShopCarHead();
            }));
          }),
      ItemBean(
          title: "nest",
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SliverDemoPage();
            }));
          }),
      ItemBean(
          title: "bloc",
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TopPage();
            }));
          }),
      ItemBean(
          title: "InheritedWidgetTestContainer",
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return InheritedWidgetTestContainer();
            }));
          }),
      ItemBean(
        title: "showDialog",
        onPress: () => _show(context),
      ),
      ItemBean(
        title: "justtest",
        onPress: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return justtest();
        })),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          Tooltip(
              message: "根据名称收索",
              child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: _searchBarDelegate(shows));
                  }))
        ],
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
          shows.length,
          (i) => RaisedButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text(shows[i].title),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: shows[i].onPress,
          ),
        ),
      ),
    );
  }
}

_show(BuildContext context) {
  test222();
  showDialog(
// 传入 context
    context: context,
// 构建 Dialog 的视图
    builder: (_) => Container(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('Custom Dialog',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.none)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 8),
                    child: FlatButton(
                        onPressed: () {
// 关闭 Dialog
                          Navigator.pop(_);
                        },
                        child: Text('确定')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class justtest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: Theme.of(context, shadowThemeOnly: true),
      child: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Custom Dialog',
                            style: TextStyle(
                                fontSize: 16, decoration: TextDecoration.none)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 8),
                        child: FlatButton(
                            onPressed: () {
// 关闭 Dialog
                              Navigator.pop(context);
                            },
                            child: Text('确定')),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    test();
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              new WordPair.random().toString(),
            ),
            RandomWordsWidget(),
          ],
        ),
      ),
    );
  }

  test() {
    String s = "s";
    CommonUtils.log2(["initState", "s".hashCode, s.hashCode]);
    s = "sdfdsf";
    CommonUtils.log2(["initState", "sdfdsf".hashCode, s.hashCode]);
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

class ItemBean {
  String title;
  String message;
  VoidCallback onPress;

  ItemBean({this.title, this.onPress, this.message});
}

class _searchBarDelegate extends SearchDelegate<String> {
  final List<ItemBean> itmes;

  _searchBarDelegate(this.itmes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? itmes
        : itmes.where((input) => input.title.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
              title: RichText(
                  text: TextSpan(
                      text: suggestionList[index]
                          .title
                          .substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text:
                            suggestionList[index].title.substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
              onTap: suggestionList[index].onPress,
            ));
  }
}
