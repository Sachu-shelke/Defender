class RecordedVideoModel {
  int? status;
  String? message;
  List<RecordedVideoData>? data;

  RecordedVideoModel({this.status, this.message, this.data});

  RecordedVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecordedVideoData>[];
      json['data'].forEach((v) {
        data!.add(RecordedVideoData.fromJson(v));
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

class RecordedVideoData {
  int? id;
  String? title;
  String? videoLink;
  int? categoryId;
  int? status;
  String? categoryName;
  String? thumbnail;

  RecordedVideoData(
      {this.id,
      this.title,
      this.videoLink,
      this.categoryId,
      this.thumbnail,
      this.status,
      this.categoryName});

  RecordedVideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoLink = json['video_link'];
    categoryId = json['category_id'];
    status = json['status'];
    categoryName = json['category_name'];
    thumbnail = json['thumbnail_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['video_link'] = videoLink;
    data['category_id'] = categoryId;
    data['status'] = status;
    data['category_name'] = categoryName;
    return data;
  }
}
