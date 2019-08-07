import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/dioHelper.dart';

class NetShowView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Nstate();
  }
}

class _Nstate extends State<NetShowView> {
  String showANS = "结果回显";

  @override
  void initState() {
    super.initState();
    // DioHelper.getInstance()
    //     .post("car/factory/lists", null)
    //     .then((m) => setState(() {
    //           showANS = m;
    //         }));
    DioHelper.getInstance()
        .post("user/homepage/userTop", null)
        .then((m) => setState(() {
              showANS = m;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(showANS, maxLines: 6, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
