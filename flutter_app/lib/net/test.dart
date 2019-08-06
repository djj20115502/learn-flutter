import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../test.dart';

main() async {
  try {
    getHttp();
  } catch (e) {
    CommonUtils.log2([e]);
  }
}

Future<String> getHttp() async {
  try {
    Response response;
    var data = {'name': '技术胖'};
    response = await Dio().get(
      "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女",
      //  queryParameters:data
    );
    return response.toString();
  } catch (e) {
    return e.toString();
  }
}

Future<String> post() async {
  try {
    Response response;
    var data = {'vehicle_type': "car"};
    response = await Dio()
        .post("http://car1.i.cacf.cn/car/factory/lists", queryParameters: data);
    return response.toString().substring(0,200);
  } catch (e) {
    return e.toString();
  }
}

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

    post().then((m) => setState(() {
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
            Text(showANS),
          ],
        ),
      ),
    );
  }
}
