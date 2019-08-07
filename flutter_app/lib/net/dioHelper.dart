import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/test.dart';

class DioHelper {
  static DioHelper _instance;
  static const String KCWC = "http://car1.i.cacf.cn/";
  Dio dio;

  ///   var dio = Dio(BaseOptions(
  ///    baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
  ///    connectTimeout: 5000,
  ///    receiveTimeout: 5000,
  ///    headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
  ///   ))
  ///
  final String proxy = "192.168.0.191:8888";
  bool isProxyChecked = true;

  Dio getDio() {
    if (dio != null) {
      return dio;
    }
    dio = Dio(
        BaseOptions(baseUrl: KCWC, connectTimeout: 5000, receiveTimeout: 5000));
    dio.interceptors.add(new InterceptorsWrapper(onRequest: (options) {
      // options.queryParameters.addAll({'vehicle_type': "car"});
      options.queryParameters
          .addAll({'token': "nDJFF9Kc3Lcldnd6VdwrPwRts2XxDfQw"});
      options.queryParameters.addAll({'user_id': "183266"});
      // options.data = {'token': "nDJFF9Kc3Lcldnd6VdwrPwRts2XxDfQw",'user_id': "183266"};
      // "http://car1.i.cacf.cn/user/homepage/userTop?token=nDJFF9Kc3Lcldnd6VdwrPwRts2XxDfQw&user_id=183266&longitude=106.493483&latitude=29.525769&machine_type=android"
      CommonUtils.log2(["DioHelper   method-------------", options.method]);
      CommonUtils.log2(["DioHelper   path---------------", options.path]);
      CommonUtils.log2(
          ["DioHelper   queryParameters----", options.queryParameters]);
      CommonUtils.log2(["DioHelper   data---------------", options.data]);
      CommonUtils.log2(["DioHelper   extra---------------", options.extra]);
      CommonUtils.log2(["DioHelper   uri----------------", options.uri]);
      return options;
    }));
    if (isProxyChecked) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return isProxyChecked && Platform.isAndroid;
        };
        client.findProxy = (url) {
          return 'PROXY $proxy';
        };
      };
    }
    return dio;
  }

  static DioHelper getInstance() {
    if (_instance == null) {
      _instance = new DioHelper();
    }
    return _instance;
  }

  close() {
    if (_instance == null) {
      return;
    }
    _instance.dio = null;
    _instance = null;
  }

  Future<String> get(String url, Map<String, dynamic> data) async {
    try {
      Response response = await getDio().get(url, queryParameters: data);
      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> post(String url, Map<String, dynamic> data) async {
    try {
      Response response =
          await getDio().post(url, data: {"sdf": "sdf"}, queryParameters: data);
      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
