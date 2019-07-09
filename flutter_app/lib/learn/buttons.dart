import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
      body: Center(

        child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("RaisedButton"),
                onPressed: () => {},
              ),
              FlatButton(
                child: Text("FlatButton"),
                onPressed: () => {},
              ),
              OutlineButton(
                child: Text("OutlineButton"),
                onPressed: () => {},
              ),
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () => {},
              ),
              RaisedButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("Submit"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () => {},
              ),
              Image(
                image: NetworkImage(
                    "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
                width: 100.0,
              ),
              Image(
                image: NetworkImage(
                    "http://pic37.nipic.com/20140113/8800276_184927469000_2.png"),
                width: 100.0,
              ),
            ]),
      ),
    );
  }
}
