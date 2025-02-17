class BannerList {
  String? id;
  String? bannerType;
  String? imageurl;

  BannerList({this.id, this.bannerType, this.imageurl});

  BannerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerType = json['banner_type'];
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_type'] = bannerType;
    data['imageurl'] = imageurl;
    return data;
  }
}
