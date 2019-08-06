import 'package:flutter_app/constant.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 中文列名与拼音对应
/// key 拼音 value 汉字
class Column {
  ///通过中文得到唯一的拼音，同音字其后加数字
  Future<String> getEnColumn(String chinese) async {

    if (chinese == null) {
      return chinese;
    }
    
    if (!ChineseHelper.isChinese(chinese)) {
      return chinese;
    }
    String en = PinyinHelper.getPinyin(chinese,
        separator: "_", format: PinyinFormat.WITHOUT_TONE);
    en = await _insertEnColumnToSpf(en, chinese);
    getSPF().then((m) => m.setString(en, chinese));
    return en;
  }

  ///通过表列表获取对应的汉字
  Future<String> getChinese(String columnName) async {
    if (columnName == null) {
      return columnName;
    }
    return getSPF().then((m) => m.getString(columnName));
  }

  SharedPreferences preferences;
  Future<SharedPreferences> getSPF() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    return preferences;
  }

  Future<String> _insertEnColumnToSpf(String en, String chinese,
      {int index: 0}) async {
    String theEn = en;
    if (index != 0) {
      theEn = en + index.toString();
    }
    String theChinese =
        await getSPF().then((onValue) => onValue.getString(theEn));
    CommonUtils.log2(["_insertEnColumnToSpf", theChinese, theEn]);
    if (theChinese == null || chinese.compareTo(theChinese) == 0) {
      return theEn;
    }
    return _insertEnColumnToSpf(en, chinese, index: index + 1);
  }
}
