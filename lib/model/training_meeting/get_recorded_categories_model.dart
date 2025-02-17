class GetTrainingVideoModel {
  int? status;
  String? message;
  List<GetTrainingVideoData>? data;

  GetTrainingVideoModel({this.status, this.message, this.data});

  GetTrainingVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetTrainingVideoData>[];
      json['data'].forEach((v) {
        data!.add(GetTrainingVideoData.fromJson(v));
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

class GetTrainingVideoData {
  int? id;
  String? categoryName;
  int? status;
  List<ChildCategory>? childCategory;

  GetTrainingVideoData(
      {this.id, this.categoryName, this.status, this.childCategory});

  GetTrainingVideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    status = json['status'];
    if (json['child_category'] != null) {
      childCategory = <ChildCategory>[];
      json['child_category'].forEach((v) {
        childCategory!.add(ChildCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['status'] = status;
    if (childCategory != null) {
      data['child_category'] = childCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCategory {
  int? id;
  String? categoryName;
  String? categoryImage;
  int? status;

  ChildCategory({this.id, this.categoryName, this.categoryImage, this.status});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['status'] = status;
    return data;
  }
}
