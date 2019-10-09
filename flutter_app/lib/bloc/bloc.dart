import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../test.dart';

class CountBLoC {
  int _count = 0;
  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;

  int get value => _count;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

CountBLoC bLoC = CountBLoC();

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: Center(
        child: StreamBuilder<int>(
            stream: bLoC.stream,
            initialData: bLoC.value,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              CommonUtils.log2(["CountBLoC 1 snapshot", snapshot.data]);

              return Text(
                'You hit me: ${snapshot.data} times',
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
             return Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UnderPage()));
          }),
    );
  }
}

void test222(){

}


class UnderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: bLoC.stream,
          initialData: bLoC.value,
          builder: (context, snapshot) {
            CommonUtils.log2(["CountBLoC 2 snapshot", snapshot.data]);
            return Text(
              "You hit me: ${snapshot.data} times",
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bLoC.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
