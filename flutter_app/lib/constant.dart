import 'package:flutter/cupertino.dart';
import 'package:flutter_app/test.dart' as prefix0;

import 'learn/buttons.dart';
import 'learn/grid.dart';
import 'learn/layout.dart';
import 'learn/list.dart';
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

  //LIST
  static const String R_ListLayoutTestRoute = "ListLayoutTestRoute";

  //grid
  static const String R_GridRoute = "GridLayout";
  //detail
  static const String R_ListDetail = "R_ListDetail";

  static final Map<String, WidgetBuilder> routes = {
    R_NewRoute: (context) => NewRoute(),
    R_TapboxA: (context) => TapboxA(),
    R_Buttons: (context) => Buttons(),
    R_FlexLayoutTestRoute: (context) => FlexLayoutTestRoute(),
    R_ListLayoutTestRoute: (context) => ListLayoutTestRoute(),
    R_GridRoute: (context) => GridLayout(),
    R_ListDetail: (context) => Detail(),
  };
}

abstract class Test {
  static const List<String> testImage = [
    "http://www.pptok.com/wp-content/uploads/2012/08/xunguang-4.jpg",
    "http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg",
    "http://pic1.nipic.com/2008-12-30/200812308231244_2.jpg",
    "http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg",
    "http://pic21.nipic.com/20120519/5454342_154115399000_2.jpg",
    "http://pic22.nipic.com/20120704/10243327_181334497194_2.jpg",
    "http://pic1.nipic.com/2009-02-10/2009210213644146_2.jpg"
  ];
  static getTestImage() {
    testCount++;
    return getTestPic(testCount);
  }

  static bool justTest = true;
  static int testCount = 0;

  static String getTestPic(int order) {
    return testImage[order % testImage.length];
  }

  static String getTestPic1() {
    testCount++;
    return getTestPic(testCount);
  }

  static const List<String> testString = [
    "销售姓名",
    "a",
    "一汽丰田 · 汉兰达",
    "机构简称机构简称",
    "机构简称机构简称机构简称机构简称机构简称机构简称",
    "您的买车招标已提交成功，请等待经销商回复",
    "等待",
    "现金折扣7折",
    "降 ¥9999.00"
  ];
  static String getTestName(int order) {
    return testString[order % testString.length];
  }

  static String getTestName1() {
    testCount++;
    return getTestName(testCount);
  }
}

abstract class CommonUtils {
  static log(String s) {
    if (!Test.justTest) {
      return;
    }
    print("djjtest:" + s);
  }

  static log2(List s) {
    if (!Test.justTest) {
      return;
    }
    print("djjtest:" + s.toString());
  }

  static String listToString(List<String> list,
      {String div = ",", String coverL = "", String coverR = ""}) {
    if (list == null || list.length == 0) {
      return "null";
    }
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(coverL + list[0] + coverR);
    for (int i = 1; i < list.length; i++) {
      stringBuffer.write(div + coverL + list[i] + coverR);
    }

    return stringBuffer.toString();
  }

  static String debugShow(String value, {String debugShow=""}) {
    if (Test.justTest) {
      return debugShow == null ? "" : debugShow;
    }
    return value;
  }
}
