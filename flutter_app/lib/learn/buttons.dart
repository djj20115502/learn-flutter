import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/commonres.dart';
import 'package:flutter_app/test.dart';

class Buttons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButtonsState();
  }
}

class _ButtonsState extends State<Buttons> {
  GlobalKey key = new GlobalKey();
  List<Widget> shows = [
    StatelessContainer(),
    StatelessContainer(),
  ];

  switchWidget() {
    CommonUtils.log("Buttons;");
    shows.insert(0, shows.removeAt(1));
    shows.forEach((m) => CommonUtils.log2([m.hashCode, m.runtimeType, m.key]));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(args),
    //   ),
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverToBoxAdapter(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             shows[0],
    //             shows[1],
    //             RaisedButton(
    //               key: key,
    //               child: Text("RaisedButton"),
    //               onPressed: () => {},
    //             ),
    //             Container(
    //               color: Color(0xFF909090),
    //               padding: EdgeInsets.all(50),
    //               child: FlatButton(
    //                 child: Text("FlatButton"),
    //                 onPressed: () => switchWidget(),
    //               ),
    //             ),
    //             OutlineButton(
    //               child: Text("OutlineButton"),
    //               onPressed: () => {},
    //             ),
    //             IconButton(
    //               icon: Icon(Icons.thumb_up),
    //               onPressed: () => {},
    //             ),
    //             RaisedButton(
    //               color: Colors.blue,
    //               highlightColor: Colors.blue[700],
    //               colorBrightness: Brightness.dark,
    //               splashColor: Colors.grey,
    //               child: Text("Submit"),
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(20.0)),
    //               onPressed: () => {},
    //             ),
    //             Image(
    //               image: NetworkImage(
    //                   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
    //               width: 100.0,
    //             ),
    //             Image(
    //               image: NetworkImage(
    //                   "http://pic37.nipic.com/20140113/8800276_184927469000_2.png"),
    //               width: 100.0,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shows,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchWidget,
        child: Icon(Icons.undo),
      ),
    );
  }
}

// class StatelessContainer extends StatelessWidget {
//    final Color color = Res.getColor();

//   @override
//   Widget build(BuildContext context) {
//       Widget rt = Container(
//       width: 100,
//       height: 100,
//       color: color,
//     );
//     CommonUtils.log2(["_stateStatelessContainer",hashCode,rt.hashCode, rt.runtimeType, rt.key,color.value,runtimeType.hashCode]);
//     return rt;
//   }
// }
class StatelessContainer extends StatefulWidget {
  // StatelessContainer({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    State<StatefulWidget> rt = _stateStatelessContainer();
    CommonUtils.log2(
      [
        "StatelessContainer",
        "createState::  StatefulWidget",
        hashCode,
        "State__",
        rt.hashCode,
      ],
    );
    return rt;
  }
}

class _stateStatelessContainer extends State<StatelessContainer> {
  final Color color = Res.getColor();
  @override
  Widget build(BuildContext context) {
    Widget rt = Container(
      key: UniqueKey(),
      width: 100,
      height: 100,
      color: color,
    );
    CommonUtils.log2([
      "_stateStatelessContainer",
      "context",
      context.hashCode,
      " context.widget",
      context.widget.hashCode,
      "hashCode::",
      hashCode,
      "rt.hashCode:::",
      rt.hashCode,
      "rt.runtimeType::",
      rt.runtimeType,
      "rt.key:::",
      rt.key,
      " color.value:::",
      color.value
    ]);
    return rt;
  }
}
