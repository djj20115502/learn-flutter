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
        CommonUtils.log2(["storeInfo", storeInfo.address]);
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
        CommonUtils.log2(["showCarList", showCarList.length]);
      });
    });
  }

  static int count = 1;

  @override
  Widget build(BuildContext context) {
    count = 2;
    if (count % 2 == 1) {
      CommonUtils.log2(["showCarList", "getNestedScrollView"]);
      return getNestedScrollView(context);
    } else {
      CommonUtils.log2(["showCarList", "getSliver"]);
      return getSliver(context);
    }
  }

  Widget getNestedScrollView(BuildContext context) {
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
          SliverToBoxAdapter(
            child: ShopCarHeadView(storeInfo: storeInfo),
          ),
          SliverSafeArea(
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(),
            ),
          ),
        ],
        body: CustomScrollView(slivers: <Widget>[
          SliverPadding(
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
        ]),
      ),
    );
  }

  Widget getSliver(BuildContext context) {
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: ShopCarHeadView(storeInfo: storeInfo),
          ),
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(15),
              0,
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
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      key: globalKey,
      color: Res.color_white,
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setWidth(45),
        left: ScreenUtil.getInstance().setWidth(15),
        bottom: ScreenUtil.getInstance().setWidth(20),
      ),
      child: Text(
        "店内车",
        style: Res.textStyle_4a4a4a_20_bold,
      ),
    );
  }

  @override
  double get maxExtent => ScreenUtil.getInstance().setWidth(90.0);

  @override
  double get minExtent => ScreenUtil.getInstance().setWidth(90.0);

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    if (globalKey.currentContext != null) {
      CommonUtils.log2([
        "height shouldRebuild globalKey.currentContext==null",
        globalKey.currentContext.size.height
      ]);
    }
    return false;
  }
}
