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


class Pagination {
  int count;
  int page;

  Pagination({this.count, this.page});

  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['page'] = this.page;
    return data;
  }
}