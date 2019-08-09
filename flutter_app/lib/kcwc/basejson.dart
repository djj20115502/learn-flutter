import 'dart:convert';

class BaseJson {
  int code;
  String msg;
  dynamic data;

  BaseJson({this.code, this.msg, this.data});

  BaseJson.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }
  BaseJson.fromJsonString(String jsonsString) {
    Map<String, dynamic> jsonMap = json.decode(jsonsString);
    code = jsonMap['code'];
    msg = jsonMap['msg'];
    data = jsonMap['data'];
  }
}
