 

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

``` flutter
flutter packages pub run build_runner build
```



