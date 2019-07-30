import 'dart:isolate';
import 'dart:math';

import 'package:flutter/services.dart';

import '../constant.dart';

class TestIsolate {
  static const platform = const MethodChannel('samples.flutter.io');

  static void testIsolate() {
    ReceivePort port = ReceivePort();
    Isolate.spawn(fun, port.sendPort);

    ///固定写法
    port.listen((t) {
      ///这里是设置当前receivePort 监听
      print("接收到其他isolate发过来的消息！");

      ///这里接收了其他isolate发送的消息
      print(t);
      print("1" + Isolate.current.debugName);

      ///接收到的为fun方法里面发送的消息
    });
    port.sendPort.send("XXX");
    print("3" + Isolate.current.debugName);
    try {
      new TestIsolate()._getxls();
    } catch (e) {
      CommonUtils.log(e.toString());
    }
  }

  static void fun(SendPort sendPort) {
    var receivePort = new ReceivePort();
    var port = receivePort.sendPort;
    port.send("a");

    ///发送消息
    sendPort.send("---");
    print("2" + Isolate.current.debugName);

    ///发送消息
    receivePort.listen((t) {
      ///这里是设置当前receivePort 监听
      print("接收到当前isolate发过来的消息！");
      print("4" + Isolate.current.debugName);

      ///这里接收了当前发送的消息
      print(t);
    });
  }

  Future<Null> _getxls() async {
    Map<dynamic, dynamic> result;
    try {
      result = await platform.invokeMethod('xls');
    } on PlatformException catch (e) {
      CommonUtils.log("result:" + e.message);
    }
    if (result == null) {
      return;
    }
    CommonUtils.log("result keys :" +
        result.runtimeType.toString() +
        result.keys.length.toString());
    for (var i in result.keys.toList()) {
      CommonUtils.log("result keys " + i.runtimeType.toString() + i.toString());
      CommonUtils.log("result runtimeType " + result[i].runtimeType.toString());
      whilelist(result[i]);
    }

    CommonUtils.log("result keys :" + result.keys.length.toString());
  }

  whilelist(Object data) {
    CommonUtils.log("whilelist  " +
        data?.runtimeType.toString() +
        data?.toString().substring(0, min(data?.toString().length, 10)));
    if (data == null) {
      return;
    }
    if (!(data is List)) {
      return;
    }
    List<dynamic> list = data as List;
    CommonUtils.log("whilelist  " + list.length.toString());
    if (list.length == 0) {
      CommonUtils.log("whilelist  list.length=0");
      return;
    }
    whilelist(list[0]);
  }
}
