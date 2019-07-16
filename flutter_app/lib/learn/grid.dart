import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class GridLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> show = List<String>.generate(1000, (i) => "test $i");
    return Scaffold(
      appBar: AppBar(
        title: Text("GridLayout"),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,///横轴间距
          mainAxisSpacing: 20,///纵轴间距
          // childAspectRatio:1 ,///宽高比
        ),
        children: List<Widget>.generate(
            1000, (i) => Image.network(Test.getTestImage(), fit: BoxFit.cover)),
      ),
    );
  }
}
