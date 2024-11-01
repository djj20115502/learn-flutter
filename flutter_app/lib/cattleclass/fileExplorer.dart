import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_app/cattleclass/readxml.dart';
import 'package:sqflite/sqflite.dart';

import '../test.dart';

class Explorer {
  //单个文件选择
  static openOne() async {
    try {
      String path =
          await FilePicker.getFilePath(type: FileType.ANY, fileExtension: "");
      CommonUtils.log2([path]);
      ReadXmlHelper.readXml(path);
    } catch (e) {
      print("Unsupported operation" + e.toString());
      CommonUtils.log2([e.toString()]);
    }
  }

  ///删除数据库
  static Future<String> delete() async {
    String name = await getDatabasesPath();
    CommonUtils.log2([name]);
    Directory directory = new Directory(name);
    if (!await directory.exists()) {
      CommonUtils.log2(["已经删除了"]);
      return null;
    }
    try {
      await directory.delete(recursive: true);
      CommonUtils.log2([await directory.exists()]);
      return null;
    } catch (e) {
      CommonUtils.log2([e]);
      return e.toString();
    }
  }
}
