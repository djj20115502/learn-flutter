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
  static bool debugUi = false;

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
    _print(s);
  }

  static log2(List s) {
    _print(s.toString());
  }

  static _print(String s) {
    if (!Test.justTest) {
      return;
    }
    String all = StackTrace.current.toString();
    StringBuffer sb = new StringBuffer();
    sb.write(" \n╔═════════════════════════════════");
    sb.write("\n║➨➨at ");
    sb.write(all.substring(all.indexOf("#2"), all.indexOf("#3")));
    sb.write("║➨➨➨➨at ");
    sb.write(all.substring(all.indexOf("#3"), all.indexOf("#4")));
    sb.write("╟───────────────────────────────────\n");
    sb.write("║");
    sb.write("djjtest:" + s);
    sb.write("\n╚═════════════════════════════════");
    print(sb.toString());
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

  static String debugShow(String value,
      {String nullString, String debugShow = "", bool forceDug = false}) {
    if (!isNullString(value)) {
      return value;
    }
    if (!isNullString(nullString)) {
      return nullString;
    }
    if ((forceDug | Test.debugUi) && !isNullString(debugShow)) {
      return debugShow;
    }
    return "";
  }

  static bool isNullString(String value) {
    if (value == null) {
      return true;
    }
    if ("" == value) {
      return true;
    }
    if ("NULL" == value.toUpperCase()) {
      return true;
    }
    return false;
  }

  static String checkNull(String value, {String nullString = ""}) {
    if (value == null) {
      return nullString;
    }
    return value;
  }

  static String addDiv(String s1, String s2, {String div = ""}) {
    if (!isNullString(s1) && !isNullString(s2)) {
      return s1 + div + s2;
    }
    return checkNull(s1) + checkNull(s2);
  }
}
