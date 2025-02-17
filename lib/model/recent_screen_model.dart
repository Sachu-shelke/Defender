class RecentAppUseModel {
  int? status;
  String? message;
  List<RecentAppUseData>? data;

  RecentAppUseModel({this.status, this.message, this.data});

  RecentAppUseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecentAppUseData>[];
      json['data'].forEach((v) {
        data!.add(RecentAppUseData.fromJson(v));
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

class RecentAppUseData {
  int? userId;
  String? title;
  String? imageUrl;
  String? functions;
  String? createdOn;

  RecentAppUseData(
      {this.userId, this.title, this.imageUrl, this.functions, this.createdOn});

  RecentAppUseData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    title = json['title'];
    imageUrl = json['image_url'];
    functions = json['functions'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['functions'] = functions;
    data['created_on'] = createdOn;
    return data;
  }
}
