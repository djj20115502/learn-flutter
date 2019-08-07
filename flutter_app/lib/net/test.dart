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

  void getData(bool ispost) {
    ispost
        ? DioHelper.getInstance()
            .postDo("user/homepage/userTop", {'user_id': "183266"}).then(
                (m) => setState(() {
                      showANS = m;
                    }))
        : DioHelper.getInstance()
            .getDo("user/homepage/userTop", {'user_id': "183266"}).then(
                (m) => setState(() {
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
            RaisedButton(
                child: Text("get网络请求"),
                onPressed: () {
                  getData(false);
                }),
            RaisedButton(
                child: Text("post网络请求"),
                onPressed: () {
                  getData(true);
                }),
            Text(showANS, maxLines: 6, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
