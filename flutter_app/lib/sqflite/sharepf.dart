import 'package:flutter_app/sqflite/column.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test.dart';

class TestSF {
  test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("key", "我们");
    String name = prefs.getString("key");
    CommonUtils.log("TestSF" + name);
    CommonUtils.log("isChinese" + ChineseHelper.isChinese("我1").toString());
    CommonUtils.log("isChinese" + ChineseHelper.isChinese("1我").toString());
    CommonUtils.log("isChinese" + ChineseHelper.isChinese("ss").toString());
    CommonUtils.log("isChinese" + ChineseHelper.isChinese("我s").toString());
    CommonUtils.log("isChinese" + ChineseHelper.isChinese("s我").toString());

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
    CommonUtils.log("涡焖" + await Column().getEnColumn("涡焖"));
    CommonUtils.log("涡焖" + await Column().getEnColumn("涡焖"));
    CommonUtils.log("涡焖" + await Column().getEnColumn("涡焖"));
    CommonUtils.log("涡焖" + await Column().getEnColumn("涡焖"));
    CommonUtils.log("涡焖" + await Column().getEnColumn("涡焖"));

    CommonUtils.log("我们" + await Column().getEnColumn("我们"));
    CommonUtils.log("我们" + await Column().getEnColumn("我们"));
    CommonUtils.log("我们" + await Column().getEnColumn("我们"));
    CommonUtils.log("蜗闷" + await Column().getEnColumn("蜗闷"));
    CommonUtils.log("窝门" + await Column().getEnColumn("窝门"));
    CommonUtils.log("窝门" + await Column().getEnColumn("窝门"));
    CommonUtils.log("沃们" + await Column().getEnColumn("沃们"));
    CommonUtils.log("--------------");
    CommonUtils.log2(["wo_men" , await Column().getChinese("wo_men")]);
    CommonUtils.log2(["wo_men1" , await Column().getChinese("wo_men1")]);
    CommonUtils.log2(["wo_men2" , await Column().getChinese("wo_men2")]);
    CommonUtils.log2(["wo_men3" , await Column().getChinese("wo_men3")]);
    CommonUtils.log2(["wo_men4" , await Column().getChinese("wo_men4")]);
    CommonUtils.log2(["wo_men5" , await Column().getChinese("wo_men5")]);
 
  }

  SharedPreferences preferences;
  Future<SharedPreferences> getSPF() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    return preferences;
  }
}
