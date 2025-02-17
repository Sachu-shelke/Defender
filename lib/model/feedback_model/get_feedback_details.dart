class GetFeedbackDetailsModel {
  String? status;
  int? code;
  String? description;
  String? message;
  List<FeedbackDetailsResponse>? response;

  GetFeedbackDetailsModel(
      {this.status, this.code, this.description, this.message, this.response});

  GetFeedbackDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['response'] != null) {
      response = <FeedbackDetailsResponse>[];
      json['response'].forEach((v) {
        response!.add(FeedbackDetailsResponse.fromJson(v));
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

class FeedbackDetailsResponse {
  String? feedbackId;
  String? ticketNo;
  String? userId;
  String? categoryId;
  String? reasonId;
  String? mobile;
  String? whatsappNo;
  String? img;
  String? problemDescription;
  String? createdOn;
  String? status;
  String? imageurl;

  FeedbackDetailsResponse(
      {this.feedbackId,
      this.ticketNo,
      this.userId,
      this.categoryId,
      this.reasonId,
      this.mobile,
      this.whatsappNo,
      this.img,
      this.problemDescription,
      this.createdOn,
      this.status,
      this.imageurl});

  FeedbackDetailsResponse.fromJson(Map<String, dynamic> json) {
    feedbackId = json['feedback_id'];
    ticketNo = json['ticket_no'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    reasonId = json['reason_id'];
    mobile = json['mobile'];
    whatsappNo = json['whatsapp_no'];
    img = json['img'];
    problemDescription = json['problem_description'];
    createdOn = json['created_on'];
    status = json['status'];
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedback_id'] = feedbackId;
    data['ticket_no'] = ticketNo;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['reason_id'] = reasonId;
    data['mobile'] = mobile;
    data['whatsapp_no'] = whatsappNo;
    data['img'] = img;
    data['problem_description'] = problemDescription;
    data['created_on'] = createdOn;
    data['status'] = status;
    data['imageurl'] = imageurl;
    return data;
  }
}
