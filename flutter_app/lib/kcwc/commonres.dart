import 'package:flutter/widgets.dart';
import 'package:flutter_app/test.dart';

abstract class Res {
  static const TextStyle textStyle_4a4a4a_20_bold = TextStyle(
    fontSize: 20,
    color: Color(0xff4a4a4a),
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle_4a4a4a_14_bold = TextStyle(
    fontSize: 14,
    color: Color(0xff4a4a4a),
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle_999999_12 = TextStyle(
    fontSize: 12,
    color: Color(0xff999999),
  );
  static const TextStyle textStyle_999999_11 = TextStyle(
    fontSize: 11,
    color: Color(0xff999999),
  );
  static const TextStyle textStyle_ff7f2c_11 = TextStyle(
    fontSize: 11,
    color: Color(0xffff7f2c),
  );

  static const TextStyle textStyle_666666_11 = TextStyle(
    fontSize: 11,
    color: Color(0xff666666),
  );

  static const Color color_red = Color(0XFFff0000);
  static const Color color_green = Color(0XFF00ff00);
  static const Color color_bulue = Color(0XFF0000ff);

  static Color getColor() {
    Test.testCount++;
    switch (Test.testCount % 3) {
      case 0:
        return color_red;
      case 1:
        return color_green;
      case 2:
        return color_bulue;
    }
    return color_bulue;
  }
}
