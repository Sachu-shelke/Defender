class NewGetGraphicsCategoryModel {
  int? status;
  String? message;
  List<NewGraphicsCategoryData>? data;
  List<NewGraphicsCategoryData>? todaysStatus;

  NewGetGraphicsCategoryModel(
      {this.status, this.message, this.todaysStatus, this.data});

  NewGetGraphicsCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewGraphicsCategoryData>[];
      json['data'].forEach((v) {
        data!.add(NewGraphicsCategoryData.fromJson(v));
      });
    }
    if (json['todaysStatus'] != null) {
      todaysStatus = <NewGraphicsCategoryData>[];
      json['todaysStatus'].forEach((v) {
        todaysStatus!.add(NewGraphicsCategoryData.fromJson(v));
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

class NewGraphicsCategoryData {
  int? id;
  String? image;
  String? description;
  String? category;

  NewGraphicsCategoryData(
      {this.id, this.image, this.description, this.category});

  NewGraphicsCategoryData.fromJson(Map<String, dynamic> json) {
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
