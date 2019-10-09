class StoreInfo {
  int bannerCount;
  List<BannerList> bannerList;
  String address;
  double envScore;
  String longitude;
  String latitude;
  int orgId;
  String orgLogo;
  String banner;
  String orgName;
  String orgFullName;
  String orgScore;
  int serviceScore;
  String tel;
  String points;
  String exp;
  String text;
  int orgTypeId;
  int star;
  int merchantType;
  int isCollect;
  int punchCount;
  int commentCount;
  int imprintCount;
  String distance;
  String business;
  int nodeId;
  int bookId;
  int orgManagementType;
  Object shareData;

  StoreInfo(
      {this.bannerCount,
      this.bannerList,
      this.address,
      this.envScore,
      this.longitude,
      this.latitude,
      this.orgId,
      this.orgLogo,
      this.banner,
      this.orgName,
      this.orgFullName,
      this.orgScore,
      this.serviceScore,
      this.tel,
      this.points,
      this.exp,
      this.text,
      this.orgTypeId,
      this.star,
      this.merchantType,
      this.isCollect,
      this.punchCount,
      this.commentCount,
      this.imprintCount,
      this.distance,
      this.business,
      this.nodeId,
      this.bookId,
      this.orgManagementType,
      this.shareData});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    bannerCount = json['banner_count'];
    if (json['banner_list'] != null) {
      bannerList = new List<BannerList>();
      json['banner_list'].forEach((v) {
        bannerList.add(new BannerList.fromJson(v));
      });
    }
    address = json['address'];
    envScore = json['env_score'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    orgId = json['org_id'];
    orgLogo = json['org_logo'];
    banner = json['banner'];
    orgName = json['org_name'];
    orgFullName = json['org_full_name'];
    orgScore = json['org_score'];
    serviceScore = json['service_score'];
    tel = json['tel'];
    points = json['points'];
    exp = json['exp'];
    text = json['text'];
    orgTypeId = json['org_type_id'];
    star = json['star'];
    merchantType = json['merchant_type'];
    isCollect = json['is_collect'];
    punchCount = json['punch_count'];
    commentCount = json['comment_count'];
    imprintCount = json['imprint_count'];
    distance = json['distance'];
    business = json['business'];
    nodeId = json['node_id'];
    bookId = json['book_id'];
    orgManagementType = json['org_management_type'];
    shareData = json['share_data'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_count'] = this.bannerCount;
    if (this.bannerList != null) {
      data['banner_list'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['env_score'] = this.envScore;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['org_id'] = this.orgId;
    data['org_logo'] = this.orgLogo;
    data['banner'] = this.banner;
    data['org_name'] = this.orgName;
    data['org_full_name'] = this.orgFullName;
    data['org_score'] = this.orgScore;
    data['service_score'] = this.serviceScore;
    data['tel'] = this.tel;
    data['points'] = this.points;
    data['exp'] = this.exp;
    data['text'] = this.text;
    data['org_type_id'] = this.orgTypeId;
    data['star'] = this.star;
    data['merchant_type'] = this.merchantType;
    data['is_collect'] = this.isCollect;
    data['punch_count'] = this.punchCount;
    data['comment_count'] = this.commentCount;
    data['imprint_count'] = this.imprintCount;
    data['distance'] = this.distance;
    data['business'] = this.business;
    data['node_id'] = this.nodeId;
    data['book_id'] = this.bookId;
    data['org_management_type'] = this.orgManagementType;
    return data;
  }
}

class BannerList {
  String imgTitle;
  String imgUrl;

  BannerList({this.imgTitle, this.imgUrl});

  BannerList.fromJson(Map<String, dynamic> json) {
    imgTitle = json['img_title'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_title'] = this.imgTitle;
    data['img_url'] = this.imgUrl;
    return data;
  }
}