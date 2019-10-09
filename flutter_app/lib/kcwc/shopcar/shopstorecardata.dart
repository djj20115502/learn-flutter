import '../basejson.dart';

class ShopStoreCarList {
  Pagination pagination;
  List<ShopStoreCarItem> list;

  ShopStoreCarList({this.pagination, this.list});

  ShopStoreCarList.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['list'] != null) {
      list = new List<ShopStoreCarItem>();
      json['list'].forEach((v) {
        list.add(new ShopStoreCarItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopStoreCarItem {
  String carName;
  String seriesName;
  int id;
  String appearanceImg;
  String interiorImg;
  String appearanceColorName;
  String interiorColorName;
  int typeExist;
  int typeShow;
  String frontImg;
  String sideImg;
  int benefit;

  ShopStoreCarItem(
      {this.carName,
      this.seriesName,
      this.id,
      this.appearanceImg,
      this.interiorImg,
      this.appearanceColorName,
      this.interiorColorName,
      this.typeExist,
      this.typeShow,
      this.frontImg,
      this.sideImg,
      this.benefit});

  ShopStoreCarItem.fromJson(Map<String, dynamic> json) {
    carName = json['car_name'];
    seriesName = json['series_name'];
    id = json['id'];
    appearanceImg = json['appearance_img'];
    interiorImg = json['interior_img'];
    appearanceColorName = json['appearance_color_name'];
    interiorColorName = json['interior_color_name'];
    typeExist = json['type_exist'];
    typeShow = json['type_show'];
    frontImg = json['front_img'];
    sideImg = json['side_img'];
    benefit = json['benefit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_name'] = this.carName;
    data['series_name'] = this.seriesName;
    data['id'] = this.id;
    data['appearance_img'] = this.appearanceImg;
    data['interior_img'] = this.interiorImg;
    data['appearance_color_name'] = this.appearanceColorName;
    data['interior_color_name'] = this.interiorColorName;
    data['type_exist'] = this.typeExist;
    data['type_show'] = this.typeShow;
    data['front_img'] = this.frontImg;
    data['side_img'] = this.sideImg;
    data['benefit'] = this.benefit;
    return data;
  }
}
