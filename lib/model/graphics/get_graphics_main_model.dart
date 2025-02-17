class GetGraphicsMainModel {
  int? status;
  String? message;
  Data? data;

  GetGraphicsMainModel({this.status, this.message, this.data});

  GetGraphicsMainModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Data {
  List<GraphicsMainData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GraphicsMainData>[];
      json['data'].forEach((v) {
        data!.add(GraphicsMainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphicsMainData {
  int? id;
  String? image;
  String? graphicsName;
  int? category;
  int? likeCount;
  int? shareCount;
  int? status;

  GraphicsMainData(
      {this.id,
      this.image,
      this.graphicsName,
      this.category,
      this.likeCount,
      this.shareCount,
      this.status});

  GraphicsMainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    graphicsName = json['graphics_name'];
    category = json['category'];
    likeCount = json['like_count'];
    shareCount = json['share_count'];
    status = json['status'];
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
