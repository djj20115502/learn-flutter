import 'package:flutter/cupertino.dart';

import 'learn/state.dart';
import 'main.dart';

abstract class Router {
  //第一个测试页面
  static const String R_NewRoute = "NewRoute";

  //按钮状态管理
  static const String R_TapboxA = "TapboxA";
  static final Map<String, WidgetBuilder> routes = {
    R_NewRoute: (context) => NewRoute(),
    R_TapboxA: (context) => TapboxA()
  };
}
