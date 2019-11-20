import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/utlis/toast.dart';

import '../test.dart';

///这里使用一个空的控件来管理这个回调
class A2FWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return A2FState();
  }
}

class A2FState extends State<A2FWidget> {
  /* 通道名称，必须与原生注册的一致*/
  static const native_to_flutter =
      const EventChannel('com.bhm.flutter.flutternb.plugins/native_to_flutter');

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 0));
  }

  StreamSubscription _subscription;

  @override
  void initState() {
    CommonUtils.log2([" A2FWidget initState"]);
    super.initState();
    if (null == _subscription) {
      _subscription = native_to_flutter
          .receiveBroadcastStream()
          .listen(_onEvent, onError: _onError);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
  }

  void _onEvent(Object event) {
    Toast.show(event, context);
    CommonUtils.log2(["_onEvent", event.toString()]);
  }

  void _onError(Object error) {
    CommonUtils.log2(["_onError", error.toString()]);
    Toast.show(error, context);
  }
}
