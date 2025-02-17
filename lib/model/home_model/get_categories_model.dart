import 'dart:convert';

class GetGraphicsCategoryModel {
  String? status;
  int? code;
  String? description;
  String? message;
  List<CategoriesResponse>? response;

  GetGraphicsCategoryModel(
      {this.status, this.code, this.description, this.message, this.response});

  GetGraphicsCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['response'] != null) {
      response = <CategoriesResponse>[];
      json['response'].forEach((v) {
        response!.add(CategoriesResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['description'] = description;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesResponse {
  String? id;
  String? categoryName;
  String? description;
  String? img;
  String? createdOn;
  String? status;
  String? imageurl;

  CategoriesResponse(
      {this.id,
      this.categoryName,
      this.description,
      this.img,
      this.createdOn,
      this.status,
      this.imageurl});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['description'];
    img = json['img'];
    createdOn = json['created_on'];
    status = json['status'];
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['img'] = img;
    data['created_on'] = createdOn;
    data['status'] = status;
    data['imageurl'] = imageurl;
    return data;
  }

  static Map<String, dynamic> toMap(CategoriesResponse json) => {
        "id": json.id,
        "category_name": json.categoryName,
        "description": json.description,
        "img": json.img,
        "createdOn": json.createdOn,
        "status": json.status,
        "imageurl": json.imageurl
      };

  static String encode(List<CategoriesResponse> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => CategoriesResponse.toMap(music))
            .toList(),
      );

  static List<CategoriesResponse> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CategoriesResponse>((item) => CategoriesResponse.fromJson(item))
          .toList();
}
