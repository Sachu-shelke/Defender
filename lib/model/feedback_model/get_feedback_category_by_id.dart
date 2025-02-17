class GetFeedbackCategoriesByIdModel {
  int? status;
  int? code;
  String? description;
  String? message;
  List<FeedbackCategoriesByIdResponse>? response;

  GetFeedbackCategoriesByIdModel(
      {this.status, this.code, this.description, this.message, this.response});

  GetFeedbackCategoriesByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['data'] != null && json['data'].runtimeType == List) {
      response = <FeedbackCategoriesByIdResponse>[];
      json['data'].forEach((v) {
        response!.add(FeedbackCategoriesByIdResponse.fromJson(v));
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

class FeedbackCategoriesByIdResponse {
  String? feedbackReasonId;
  String? feedbackCatId;
  String? reasonName;
  String? description;
  String? img;
  String? createdOn;
  String? status;

  FeedbackCategoriesByIdResponse(
      {this.feedbackReasonId,
      this.feedbackCatId,
      this.reasonName,
      this.description,
      this.img,
      this.createdOn,
      this.status});

  FeedbackCategoriesByIdResponse.fromJson(Map<String, dynamic> json) {
    feedbackReasonId = json['id'].toString();
    feedbackCatId = json['feedback_cat_id'].toString();
    reasonName = json['reason_name'];
    description = json['description'];
    img = json['img'];
    createdOn = json['created_on'];
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedback_reason_id'] = feedbackReasonId;
    data['feedback_cat_id'] = feedbackCatId;
    data['reason_name'] = reasonName;
    data['description'] = description;
    data['img'] = img;
    data['created_on'] = createdOn;
    data['status'] = status;
    return data;
  }
}
