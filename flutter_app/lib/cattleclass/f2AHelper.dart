import 'package:flutter/services.dart';

///https://www.jianshu.com/p/f2755c301a3e 只支持这几个类型
class F2AHelper {
  static const platform = const MethodChannel('samples.flutter.io');

  static Future<T> invokeMethod<T>(String method, [dynamic arguments]) async {
    return platform.invokeMethod(method, arguments);
  }

  //读取xml方法，返回的是map，对应key为表名。value是一个2维数组的数字
  static const String KEY_XLS = "xls";

  //只是一个测试，返回一个string
  static const String KEY_TEST="just_test";
}
