import 'package:flutter_app/constant.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TestSF {
  test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("key", "我们");
    String name = prefs.getString("key");
    CommonUtils.log("TestSF" + name);

    String str = "天府广场";

    //字符串拼音首字符
    String shortpy = PinyinHelper.getShortPinyin(str); // tfgc

    //字符串首字拼音
    String firstWord = PinyinHelper.getFirstWordPinyin(str); // tian
    

    String pinyin1 = PinyinHelper.getPinyin(str); //tian fu guang chang
    String pinyin2 = PinyinHelper.getPinyin(str,
        separator: "_", format: PinyinFormat.WITHOUT_TONE);

    print("shortpy: " + shortpy);
    print("firstWord: " + firstWord);
    print("pinyin1: " + pinyin1);
    print("pinyin2: " + pinyin2);

    //添加用户自定义字典
    List<String> dict1 = ['耀=yào', '老=lǎo'];
    PinyinHelper.addPinyinDict(dict1); //拼音字典
    List<String> dict2 = ['奇偶=jī,ǒu', '成都=chéng,dū'];
    PinyinHelper.addMultiPinyinDict(dict2); //多音字词组字典
    List<String> dict3 = ['倆=俩', '們=们'];
    ChineseHelper.addChineseDict(dict3);
  }

  SharedPreferences preferences;
  Future<SharedPreferences> getSPF() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    return preferences;
  }
}
