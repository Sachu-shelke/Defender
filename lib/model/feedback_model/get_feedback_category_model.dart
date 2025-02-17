class GetFeedbackCategoryModel {
  int? status;
  int? code;
  String? description;
  String? message;
  List<FeedbackCategoryResponse>? response;

  GetFeedbackCategoryModel(
      {this.status, this.code, this.description, this.message, this.response});

  GetFeedbackCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['data'] != null) {
      response = <FeedbackCategoryResponse>[];
      json['data'].forEach((v) {
        response!.add( FeedbackCategoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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

class FeedbackCategoryResponse {
  String? feedbackCatId;
  String? categoryName;
  String? description;
  String? img;
  String? createdOn;
  String? status;
  String? imageurl;

  FeedbackCategoryResponse(
      {this.feedbackCatId,
      this.categoryName,
      this.description,
      this.img,
      this.createdOn,
      this.status,
      this.imageurl});

  FeedbackCategoryResponse.fromJson(Map<String, dynamic> json) {
    feedbackCatId = json['id'].toString();
    categoryName = json['category_name'];
    description = json['description'];
    img = json['img'].toString();
    createdOn = json['created_on'];
    status = json['status'].toString();
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedback_cat_id'] = feedbackCatId;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['img'] = img;
    data['created_on'] = createdOn;
    data['status'] = status;
    data['imageurl'] = imageurl;
    return data;
  }
}
