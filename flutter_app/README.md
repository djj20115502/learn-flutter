 

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