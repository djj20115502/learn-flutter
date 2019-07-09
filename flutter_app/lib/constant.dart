import 'package:flutter/cupertino.dart';

import 'learn/buttons.dart';
import 'learn/layout.dart';
import 'learn/state.dart';
import 'main.dart';

abstract class Router {
  //第一个测试页面
  static const String R_NewRoute = "NewRoute";

  //按钮状态管理
  static const String R_TapboxA = "TapboxA";

  //按钮样式
  static const String R_Buttons = "Buttons";

  //布局
  static const String R_FlexLayoutTestRoute = "FlexLayoutTestRoute";

  static final Map<String, WidgetBuilder> routes = {
    R_NewRoute: (context) => NewRoute(),
    R_TapboxA: (context) => TapboxA(),
    R_Buttons: (context) => Buttons(),
    R_FlexLayoutTestRoute: (context) => FlexLayoutTestRoute(),
  };
}
