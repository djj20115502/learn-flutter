import 'package:flutter/widgets.dart';
import 'package:flutter_app/kcwc/commonres.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../test.dart';

class ShopCarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x45343412),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Image.network(
                Test.getTestImage(),
                fit: BoxFit.cover,
                height: ScreenUtil.getInstance().setWidth(113),
                width: double.infinity,
              ),
              Positioned(
                top: ScreenUtil.getInstance().setWidth(102),
                child: Text("111111"),
              )
            ],
          ),
          Container(
            padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(15)),
            child: Text(
              "车系+2016款 30 2016款2016款2016款2016款 ",
              style: Res.textStyle_4a4a4a_14_bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(15)),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "外观 ",
                style: Res.textStyle_999999_11,
              ),
              TextSpan(
                text: "朱鹭白 ",
                style: Res.textStyle_666666_11,
              ),
              TextSpan(
                text: "内饰 ",
                style: Res.textStyle_999999_11,
              ),
              TextSpan(
                text: "黑色",
                style: Res.textStyle_666666_11,
              )
            ])),
          ),
        ],
      ),
    );
  }
}
