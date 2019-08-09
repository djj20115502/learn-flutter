import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kcwc/shopcar/shopcaritem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../test.dart';

class SliverDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Sliver Demo'),
            centerTitle: true,
            // 展开的高度
            expandedHeight: 300.0,
            // 强制显示阴影
            forceElevated: true,
            // 设置该属性，当有下滑手势的时候，就会显示 AppBar
//        floating: true,
            // 该属性只有在 floating 为 true 的情况下使用，不然会报错
            // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
            // 当下滑到一定比例，会自动把 AppBar 展开
//        snap: true,
            // 设置该属性使 Appbar 折叠后不消失
//        pinned: true,
            // 通过这个属性设置 AppBar 的背景
            flexibleSpace: FlexibleSpaceBar(
//          title: Text('Expanded Title'),
              // 背景折叠动画
              collapseMode: CollapseMode.parallax,
              background: Image.asset('images/timg.jpg', fit: BoxFit.cover),
            ),
          ),

          // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
          // 可以在 child 属性加入需要展示的部件
         SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    child: Image.network(
                      Test.getTestImage(),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
        ],
      ),
    );
  }
}
