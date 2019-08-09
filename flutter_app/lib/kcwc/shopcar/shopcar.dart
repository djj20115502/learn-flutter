import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/basejson.dart';
import 'package:flutter_app/kcwc/shopcar/head.dart';
import 'package:flutter_app/kcwc/shopcar/shopInfo.dart';
import 'package:flutter_app/net/dioHelper.dart';

import '../../test.dart';

class ShopCarHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCarHeadState();
  }
}

StoreInfo storeInfo;

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
      setState(() {});
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
              child: ShopCarHeadView(storeInfo: storeInfo))
        ],
      ),
    );
  }
}
