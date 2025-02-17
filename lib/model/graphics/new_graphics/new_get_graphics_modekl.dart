import 'dart:convert';

class NewGetGraphicsModel {
  int? status;
  String? message;
  List<NewGetGraphicsData>? data;

  NewGetGraphicsModel({this.status, this.message, this.data});

  NewGetGraphicsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewGetGraphicsData>[];
      json['data'].forEach((v) {
        data!.add(NewGetGraphicsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewGetGraphicsData {
  String? graphicsDetailGroup;
  List<Graphics>? graphics;

  NewGetGraphicsData({this.graphicsDetailGroup, this.graphics});

  NewGetGraphicsData.fromJson(Map<String, dynamic> json) {
    graphicsDetailGroup = json['cat_name'];
    if (json['cat_data'] != null) {
      graphics = <Graphics>[];
      json['cat_data'].forEach((v) {
        graphics!.add(Graphics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_name'] = graphicsDetailGroup;
    if (graphics != null) {
      data['cat_data'] = graphics!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Map<String, dynamic> toMap(NewGetGraphicsData json) => {
        'cat_name': json.graphicsDetailGroup,
        'cat_data': json.graphics,
      };

  static String encode(List<NewGetGraphicsData> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => NewGetGraphicsData.toMap(music))
            .toList(),
      );

  static List<NewGetGraphicsData> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<NewGetGraphicsData>((item) => NewGetGraphicsData.fromJson(item))
          .toList();
}

class Graphics {
  num? id;
  String? image;
  String? graphicsName;
  num? category;
  num? likeCount;
  num? shareCount;
  num? isLike;
  num? isShare;
  num? status;

  Graphics(
      {this.id,
      this.image,
      this.graphicsName,
      this.category,
      this.likeCount,
      this.shareCount,
      this.isLike,
      this.isShare,
      this.status});

  Graphics.fromJson(Map<String, dynamic> json) {
    id = num.parse(json['id'].toString());
    image = json['image'];
    graphicsName = json['graphics_name'];
    category = num.parse(json['category'].toString());
    likeCount = json['total_like_count'] == null
        ? num.parse(json['like_count'].toString())
        : num.parse(json['total_like_count'].toString());
    isLike =
        json['is_like'] == null ? 0 : num.parse(json['is_like'].toString());
    isShare =
        json['is_share'] == null ? 0 : num.parse(json['is_share'].toString());
    shareCount = json['total_share_count'] == null
        ? num.parse(json['share_count'].toString())
        : num.parse(json['total_share_count'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['graphics_name'] = graphicsName;
    data['category'] = category;
    data['like_count'] = likeCount;
    data['share_count'] = shareCount;
    data['status'] = status;
    return data;
  }
}
