class GetGraphicsCategoryModel {
  int? status;
  String? message;
  List<GraphicsCategoryData>? data;
  List<GraphicsCategoryData>? todaysStatus;

  GetGraphicsCategoryModel(
      {this.status, this.todaysStatus, this.message, this.data});

  GetGraphicsCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GraphicsCategoryData>[];
      json['data'].forEach((v) {
        data!.add(GraphicsCategoryData.fromJson(v));
      });
    }
    if (json['todaysStatus'] != null) {
      todaysStatus = <GraphicsCategoryData>[];
      json['todaysStatus'].forEach((v) {
        todaysStatus!.add(GraphicsCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['todaysStatus'] = todaysStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphicsCategoryData {
  int? id;
  String? image;
  String? description;
  String? category;

  GraphicsCategoryData({this.id, this.image, this.description, this.category});

  GraphicsCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['category'] = category;
    return data;
  }
}
