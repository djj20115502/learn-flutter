import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/basejson.dart';
import 'package:flutter_app/kcwc/shopcar/shopInfo.dart';
import 'package:flutter_app/kcwc/utlis.dart';
import 'package:flutter_app/net/dioHelper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../test.dart';

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

StoreInfo storeInfo;

String orgName = "";
String orgAddress = "";

class _ShopCarHeadState extends State<ShopCarHead> {
  @override
  void initState() {
    super.initState();
    DioHelper.getInstance().getDo("orgshop/detail", {
      "org_id": "100628",
    }).then((jsonData) {
      CommonUtils.log2(
          ["_ShopCarHeadState", BaseJson.fromJsonString(jsonData).data]);
      storeInfo = StoreInfo.fromJson(BaseJson.fromJsonString(jsonData).data);
      CommonUtils.log2(["_ShopCarHeadState storeInfo", storeInfo.address]);
      setState(() {
        orgName = storeInfo.orgName;
        orgAddress = storeInfo.address;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("店内车"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0x33ff5472),
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil.getInstance().setWidth(15),
                    ScreenUtil.getInstance().setWidth(11),
                    ScreenUtil.getInstance().setWidth(15),
                    0),
                child: Container(
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Expanded(
                        flex: 240,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Offstage(
                              offstage: CommonUtils.isNullString(orgName),
                              child: Text(
                                CommonUtils.debugShow(orgName,
                                    debugShow:
                                        "机构简称机构简称机构机构简称机构简称机构机构简称机构简称机构"),
                                style: textStyle_4a4a4a_20,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Offstage(
                              offstage: CommonUtils.isNullString(orgAddress),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil.getInstance().setWidth(10)),
                                child: Text(
                                  CommonUtils.debugShow(orgAddress,
                                      debugShow:
                                          "这里是地址地址地址地址地这里是这里是地址地址地址地址地这里是地址地址地址地址地址266号这里是地址地址地址地址地址266号址266号地址地址地址地址地址266号这里是地址地址地址地址地址266号址266号"),
                                  style: textStyle_999999_12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              color: Color(0x33ff44ff),
                              padding: EdgeInsets.only(
                                  top: ScreenUtil.getInstance().setWidth(10)),
                              child: Row(
                                children: <Widget>[
                                  //打卡
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: CommonUtils.debugShow(
                                          storeInfo == null
                                              ? "0"
                                              : storeInfo.punchCount.toString(),
                                          debugShow: "14"),
                                      style: textStyle_ff7f2c_11,
                                    ),
                                    TextSpan(
                                      text: "打卡",
                                      style: textStyle_999999_11,
                                    )
                                  ])),
                                  //游记
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance()
                                            .setWidth(10)),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: CommonUtils.debugShow(
                                            storeInfo == null
                                                ? "0"
                                                : storeInfo.imprintCount
                                                    .toString(),
                                            debugShow: "14"),
                                        style: textStyle_ff7f2c_11,
                                      ),
                                      TextSpan(
                                        text: "游记",
                                        style: textStyle_999999_11,
                                      )
                                    ])),
                                  ),
                                  //点评
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance()
                                            .setWidth(10)),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: CommonUtils.debugShow(
                                            storeInfo == null
                                                ? "0"
                                                : storeInfo.commentCount
                                                    .toString(),
                                            debugShow: "55W"),
                                        style: textStyle_ff7f2c_11,
                                      ),
                                      TextSpan(
                                        text: "点评",
                                        style: textStyle_999999_11,
                                      )
                                    ])),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 105,
                        child: Image.network(
                          CommonUtils.debugShow(
                              storeInfo == null
                                  ? "null"
                                  : Utils.buildImgUrl(storeInfo.banner),
                              debugShow: Test.getTestImage()),
                          fit: BoxFit.cover,
                          height: ScreenUtil.getInstance().setWidth(70),
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
