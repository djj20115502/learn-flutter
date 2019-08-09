import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/basejson.dart';
import 'package:flutter_app/kcwc/commonres.dart';
import 'package:flutter_app/kcwc/shopcar/head.dart';
import 'package:flutter_app/kcwc/shopcar/shopInfo.dart';
import 'package:flutter_app/kcwc/shopcar/shopcaritem.dart';
import 'package:flutter_app/kcwc/shopcar/shopstorecardata.dart';
import 'package:flutter_app/net/dioHelper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../test.dart';

class ShopCarHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCarHeadState();
  }
}

//头部商户信息
//http://car1.i.cacf.cn/orgshop/detail?org_id=100628&token=nDJFF9Kc3Lcldnd6VdwrPwRts2XxDfQw&machine_type=android
StoreInfo storeInfo;

//底部店内车信息
//http://car1.i.cacf.cn/store/car/existlist?pageSize=12&org_id=100628&token=nDJFF9Kc3Lcldnd6VdwrPwRts2XxDfQw&page=1&machine_type=android

ShopStoreCarList shopStoreCarList;
final List<ShopStoreCarItem> showCarList = new List();

class _ShopCarHeadState extends State<ShopCarHead> {
  @override
  void initState() {
    super.initState();

    DioHelper.getInstance().getDo("orgshop/detail", {
      "org_id": "100628",
    }).then((jsonData) {
      CommonUtils.log2([
        "orgshop/detail",
        BaseJson.fromJsonString(jsonData).data,
      ]);
      setState(() {
        storeInfo = StoreInfo.fromJson(BaseJson.fromJsonString(jsonData).data);
      });
    });

    DioHelper.getInstance().getDo("store/car/existlist", {
      "pageSize": "12",
      "page": "1",
      "org_id": "100628",
    }).then((jsonData) {
      CommonUtils.log2([
        "store/car/existlist",
        BaseJson.fromJsonString(jsonData).data,
      ]);
      setState(() {
        shopStoreCarList =
            ShopStoreCarList.fromJson(BaseJson.fromJsonString(jsonData).data);
        showCarList.addAll(shopStoreCarList.list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("店内车"),
    //     actions: <Widget>[
    //       IconButton(
    //           icon: Icon(Icons.save),
    //           onPressed: () {
    //             setState(() {});
    //           })
    //     ],
    //   ),
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverAppBar(
    //         automaticallyImplyLeading: false,
    //         pinned: true,
    //         floating: true,
    //         snap: true,
    //         expandedHeight: 250.0,
    //         flexibleSpace: ShopCarHeadView(storeInfo: storeInfo),
    //       ),
    //       SliverToBoxAdapter(
    //         child: ShopCarHeadView(storeInfo: storeInfo),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Container(
    //           padding: EdgeInsets.only(
    //             top: ScreenUtil.getInstance().setWidth(45),
    //             left: ScreenUtil.getInstance().setWidth(15),
    //           ),
    //           child: Text(
    //             "店内车",
    //             style: Res.textStyle_4a4a4a_20_bold,
    //           ),
    //         ),
    //       ),
    //       SliverPadding(
    //         padding: EdgeInsets.fromLTRB(
    //           ScreenUtil.getInstance().setWidth(15),
    //           ScreenUtil.getInstance().setWidth(20),
    //           ScreenUtil.getInstance().setWidth(15),
    //           ScreenUtil.getInstance().setWidth(20),
    //         ),
    //         sliver: SliverGrid(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2,
    //             crossAxisSpacing: ScreenUtil.getInstance().setWidth(8),
    //             mainAxisSpacing: ScreenUtil.getInstance().setWidth(35),
    //             childAspectRatio: 169 / 200,
    //           ),
    //           delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //               return ShopCarItem(shopStoreCarItem: showCarList[index]);
    //             },
    //             childCount: showCarList.length,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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
      body: NestedScrollView(
        headerSliverBuilder: (context, s) => <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace: ShopCarHeadView(storeInfo: storeInfo),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(45),
                left: ScreenUtil.getInstance().setWidth(15),
              ),
              child: Text(
                "店内车",
                style: Res.textStyle_4a4a4a_20_bold,
              ),
            ),
          )
        ],
        body: Flexible(
          child: SliverPadding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(15),
              ScreenUtil.getInstance().setWidth(20),
              ScreenUtil.getInstance().setWidth(15),
              ScreenUtil.getInstance().setWidth(20),
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ScreenUtil.getInstance().setWidth(8),
                mainAxisSpacing: ScreenUtil.getInstance().setWidth(35),
                childAspectRatio: 169 / 200,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ShopCarItem(shopStoreCarItem: showCarList[index]);
                },
                childCount: showCarList.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
