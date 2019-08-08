import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopCarHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCarHeadState();
  }
}

final TextStyle textStyle_4a4a4a_20 = TextStyle(
  fontSize: 20,
  color: Color(0xff4a4a4a),
);

final TextStyle textStyle_999999_12 = TextStyle(
  fontSize: 12,
  color: Color(0xff999999),
);
final TextStyle textStyle_999999_11 = TextStyle(
  fontSize: 11,
  color: Color(0xff999999),
);
final TextStyle textStyle_ff7f2c_11 = TextStyle(
  fontSize: 11,
  color: Color(0xffff7f2c),
);

class _ShopCarHeadState extends State<ShopCarHead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("店内车")),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: ScreenUtil.getInstance().setSp(17),
            left: ScreenUtil.getInstance().setSp(15),
            child: Text(
              "机构简称机构简称机构",
              style: textStyle_4a4a4a_20,
            ),
          ),
          Positioned(
            top: 57,
            left: 15,
            child: Text(
              "这里是地址地址地址地址地址266号",
              style: textStyle_999999_12,
            ),
          ),
          Positioned(
              top: 67,
              left: 15,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "1111", style: textStyle_ff7f2c_11),
                    TextSpan(text: "打卡", style: textStyle_999999_11),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
