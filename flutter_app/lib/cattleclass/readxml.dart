import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_app/sqflite/excel.dart';

import '../test.dart';
import 'f2AHelper.dart';

class ReadXmlHelper {
  static const String EXTENSION_XLS = "xls";
  static const String EXTENSION_XLSX = "xlsx";

  static void readXml(String file) {
    new ReadXmlHelper()._getxls(file);
  }

  /// 通过文件地址读取xml文件
  /// [file] 文件地址
  Future<Null> _getxls(String file) async {
    if (file == null || file.length == 0) {
      return;
    }
    if (!file.endsWith(EXTENSION_XLS) && !file.endsWith(EXTENSION_XLSX)) {
      return;
    }
    Map<dynamic, dynamic> result;
    try {
      result = await F2AHelper.invokeMethod(F2AHelper.KEY_XLS, file);
    } on PlatformException catch (e) {
      CommonUtils.log("result:" + e.message);
    }
    if (result == null) {
      return;
    }
    CommonUtils.log2([
      "result keys :",
      result.runtimeType.toString(),
      result.keys.length.toString()
    ]);

    ///xml的第一层的数据是一个 表名：数据的map
    for (var i in result.keys.toList()) {
      CommonUtils.log2([
        "result keys :",
        i.runtimeType.toString(),
        i.toString(),
        result[i].runtimeType.toString()
      ]);
      // whilelist(result[i]);
      writeToDb(i.toString(), result[i]);
    }
  }

  /// 这里是写入数据库
  /// [tableName] xml表名称，一个文件能有多个表，
  /// [list] 具体的xml数据，正确的数据是一个2维数组，按行排。所以第一行默认就是没一列的名称标识
  writeToDb(String tableName, Object list) async {
    CommonUtils.log2([tableName, list.runtimeType.toString()]);
    if ("勿动".compareTo(tableName) == 0) {
      return;
    }
    if (list is! List) {
      return;
    }
    List L1 = list as List;
    if (L1 == null || L1.length < 1 || L1[0] is! List) {
      return;
    }
    try {
      List<String> columnNames = new List<String>.from(L1[0]);
      List<List<String>> data = new List();
      for (int i = 1; i < L1.length; i++) {
        data.add(new List<String>.from(L1[i]));
      }
      await new Excel()
          .insertData(tableName, columnNames, data, needToEN: true);
    } catch (e) {
      CommonUtils.log2(["error", e]);
    }
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
