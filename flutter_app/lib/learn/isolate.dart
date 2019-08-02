import 'dart:isolate';

import '../test.dart';

main() async {
  try {
    await tyrcar().catchError((e) => CommonUtils.log2([e]));
  } catch (e) {
    CommonUtils.log2([e]);
  }
}

Future tyrcar() async {
  var receivePort = new ReceivePort();
  await Isolate.spawn(echo, receivePort.sendPort);

  // 'echo'发送的第一个message，是它的SendPort
  var sendPort = await receivePort.first;
  CommonUtils.log2(['旧的', Isolate.current.hashCode.toString()]);

  var msg = await sendReceive(sendPort, "foo");
  CommonUtils.log2(
      ['received', msg, '旧的', Isolate.current.hashCode.toString()]);

  msg = await sendReceive(sendPort, "bara");
  CommonUtils.log2(
      ['received', msg, '旧的', Isolate.current.hashCode.toString()]);
      var a= new TestObject(data:"d123456");

  var ans = await sendReceive(sendPort, a)
      .catchError((m) => CommonUtils.log2([m]));
  CommonUtils.log2(
      ['received', ans.runtimeType, '旧的', Isolate.current.hashCode.toString(),a.hashCode,ans.hashCode,ans.toString()]);
}

/// 新isolate的入口函数
echo(SendPort sendPort) async {
  // 实例化一个ReceivePort 以接收消息
  var port = new ReceivePort();

  // 把它的sendPort发送给宿主isolate，以便宿主可以给它发送消息
  sendPort.send(port.sendPort);
  print('新的   ' + Isolate.current.hashCode.toString());

  // 监听消息
  await for (var msg in port) {
    CommonUtils.log2([
      '新的',
      Isolate.current.hashCode.toString(),
      "msg:::",
      msg,
      msg[0].runtimeType
    ]);
    var data = msg[0];
    SendPort replyTo = msg[1];
    CommonUtils.log2(
        ["data.runtimeType is String", data.runtimeType,data.hashCode]);
    if (data is String) {
      replyTo.send(data + "回复");
    } else {
      replyTo.send(data);
    }
    if (data == "bar") port.close();
    
  }
}

/// 对某个port发送消息，并接收结果
Future sendReceive(SendPort port,var msg) {
  ReceivePort response = new ReceivePort();
  port.send([msg, response.sendPort]);  
  return response.first;
}

class TestObject {
  String data;
  TestObject({this.data});

  @override
  String toString() {
     return data;
  }
}

class TestObject2 {}
