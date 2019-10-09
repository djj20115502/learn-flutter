 

# flutter_app
 

## 资料网站

- [技术胖-UI](http://jspang.com)

- [掘金](https://juejin.im/post/5c876e17f265da2de165dc09)

- [flutter中文网](https://book.flutterchina.club/)

## 网络访问

get用queryParameters参数，post用data参数。extra参数并没有什么实际的作用

- [技术胖](http://jspang.com/posts/2019/03/01/flutter-shop.html#%E7%AC%AC05%E8%8A%82-dio%E5%9F%BA%E7%A1%80-%E5%BC%95%E5%85%A5%E5%92%8C%E7%AE%80%E5%8D%95%E7%9A%84get%E8%AF%B7%E6%B1%82)

- [中文网](https://book.flutterchina.club/chapter11/dio.html)

这里技术胖的博客有点的问题， post是用的queryParameters的参数，这个参数其实应该是get使用的。post使用的应该是data参数。

1. 在最后拼接URI的时候用到的只是queryParameters参数。[DefaultHttpClientAdapter.fetch](https://github.com/flutterchina/dio/blob/cad527f645edb52b3927c6cfdce7e3aa30f96090/package_src/lib/src/adapter.dart#L122)中最后openurl的时候用的就是 [URI](https://github.com/flutterchina/dio/blob/cad527f645edb52b3927c6cfdce7e3aa30f96090/package_src/lib/src/options.dart#L237)。只拼接了 queryParameters，其他的什么extra并没加进来

2. 在head拼接的时候 [dio._transformData](https://github.com/flutterchina/dio/blob/cad527f645edb52b3927c6cfdce7e3aa30f96090/package_src/lib/src/dio.dart#L829)实际上只拼接了data的相关数据，其他的数据是并没有放到head中的。
[dio说明](https://pub.dev/packages/dio#examples)参数也是放在data中，上面的博客应该是有错误的。

## JSON解析

- [中文网](https://book.flutterchina.club/chapter11/json_model.html)

由于这里不支持反射，所以原本的那些框架都不能用，这个提供的方案其实都是本地自动生成相关的代码。

### 方案1：使用官方的方式

这种方案显得很臃肿，引入一个个包不说还要命令生成。太麻烦。
git:283e705a6ce17da3f05c2ed58951501966b13fe6

#### 1. 加入相关的依赖 pubspec.yaml

``` flutter
dependencies:
  # Your other regular dependencies here
  json_annotation: ^2.0.0

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^1.0.0
  json_serializable: ^2.0.0

```

#### 2. 自己写相关的原始类，预留申明 [参考](https://flutterchina.club/json/#%E4%BB%A5json_serializable%E7%9A%84%E6%96%B9%E5%BC%8F%E5%88%9B%E5%BB%BAmodel%E7%B1%BB)

#### 3. 运行代码生成程序 [参考](https://flutterchina.club/json/#%E8%BF%90%E8%A1%8C%E4%BB%A3%E7%A0%81%E7%94%9F%E6%88%90%E7%A8%8B%E5%BA%8F)

``` flutter
flutter packages pub run build_runner build
```

### 方案2 直接生成模板

直接用工具生成需要的代码，不必转几次。这里唯一不友好的是，这样不能用@JsonKey这种关键字，来起别名，但是这样无伤大雅。要别名手动改就行。而且，实际运用中并没有多少次用到了别名。

[工具网站](https://javiercbk.github.io/json_to_dart/)

#### 1. 由于无法泛型实例化，这里要手动解析下基类数据

只能将具体的数据放在data中，当string处理，然后进一步的解析json。[参考](./lib/kcwc/basejson.dart)

#### 2. 复杂的数据结构这个工具网站无法处理，也是需要自己去添加

## UI刷新

### StatelessWidget和StatefulWidget,刷新效果不同

[问题博客](https://juejin.im/post/5ca2152f6fb9a05e1a7a9a26) **原因: 构建方式不同**

1. **StatelessWidget** 对应的是[StatelessElement](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L3966),构建Widget的时候是直接用当前的的[该StatelessWidget来build](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L606)，也就是我们写的代码部分。

``` flutter
    Widget build() => widget.build(this);
```

2. **StatefulWidget** 对应的是[StatefulElement](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L3986),构建Widget的时候使用的是自定义的[state的build](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L4012)。由于在初始化的时候就已经构建了state,所以如果这里的更新[canUpdate](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L442)为true的时候，只设置了新的。

``` flutter
    Widget build() => state.build(this);
```
所以这里会出现一个问题，当Widget发生变化需要Element更新的时候，[updateChild](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L2854)的时候，StatelessWidget只要涉及到更新，都会重新去build。但是,StatefulWidget时,判断[canUpdate](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L442)为true的时候。由于调用[update](https://github.com/flutter/flutter/blob/v1.7.10/packages/flutter/lib/src/widgets/framework.dart#L2930)只涉及到更新了StatefulWidget。但是并不会更新重新生成新的state,这个时候的state还会是旧的。所有构建出来的都是之前的StatefulWidget的state。这里感觉像是个bug。

解决方案就是通过添加key使得canUpdate判断为false。


