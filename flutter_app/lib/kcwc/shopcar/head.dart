import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/shopcar/shopInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../test.dart';
import '../commonres.dart';
import '../utlis.dart';

class ShopCarHeadView extends StatelessWidget {
  final StoreInfo storeInfo;

  ShopCarHeadView({Key key, this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String orgName = storeInfo?.orgName;
    String orgAddress = storeInfo?.address;
    String daka = storeInfo?.punchCount.toString();
    String youji = storeInfo?.imprintCount.toString();
    String dianpin = storeInfo?.commentCount.toString();
    String cover = Utils.buildImgUrl(storeInfo?.banner);

    CommonUtils.log2(["orgName  $orgName", "orgAddress::$orgAddress "]);

    return Padding(
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
                          debugShow: "机构简称机构简称机构机构简称机构简称机构机构简称机构简称机构"),
                      style: Res.textStyle_4a4a4a_20_bold,
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
                        style: Res.textStyle_999999_12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    // color: Color(0x33ff44ff),
                    padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(10),
                    ),
                    child: Row(
                      children: <Widget>[
                        //打卡
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: CommonUtils.debugShow(daka,
                                    debugShow: "14"),
                                style: Res.textStyle_ff7f2c_11,
                              ),
                              TextSpan(
                                text: "打卡",
                                style: Res.textStyle_999999_11,
                              )
                            ],
                          ),
                        ),
                        //游记
                        Container(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(10)),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: CommonUtils.debugShow(youji,
                                      debugShow: "14"),
                                  style: Res.textStyle_ff7f2c_11,
                                ),
                                TextSpan(
                                  text: "游记",
                                  style: Res.textStyle_999999_11,
                                )
                              ],
                            ),
                          ),
                        ),
                        //点评
                        Container(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(10)),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: CommonUtils.debugShow(dianpin,
                                      debugShow: "55W"),
                                  style: Res.textStyle_ff7f2c_11,
                                ),
                                TextSpan(
                                  text: "点评",
                                  style: Res.textStyle_999999_11,
                                )
                              ],
                            ),
                          ),
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
                  cover,
                  debugShow: Test.getTestImage(),
                  forceDug: true,
                ),
                fit: BoxFit.cover,
                height: ScreenUtil.getInstance().setWidth(70),
              ),
            )
          ],
        ),
      ),
    );
  }
}
