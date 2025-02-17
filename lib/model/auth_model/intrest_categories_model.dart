class GetInterestCategoriesModel {
  int? status;
  int? code;
  String? description;
  String? message;
  List<InterestCategoriesResponse>? response;

  GetInterestCategoriesModel(
      {this.status, this.code, this.description, this.message, this.response});

  GetInterestCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['data'] != null) {
      response = <InterestCategoriesResponse>[];
      json['data'].forEach((v) {
        response!.add(InterestCategoriesResponse.fromJson(v));
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

class InterestCategoriesResponse {
  int? interestId;
  String? interestName;
  String? createdOn;
  String? interestCatId;
  String? icon;
  bool? isSelected;

  InterestCategoriesResponse(
      {this.interestId, this.interestName, this.createdOn, this.interestCatId});

  InterestCategoriesResponse.fromJson(Map<String, dynamic> json) {
    interestId = json['id'];
    interestName = json['intrest_name'];
    createdOn = json['created_on'];
    interestCatId = json['interest_cat_id'];
    icon = json['icon'];
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['interest_id'] = interestId;
    data['interest_name'] = interestName;
    data['created_on'] = createdOn;
    data['interest_cat_id'] = interestCatId;
    data['icon'] = icon;
    data['isSelected'] = isSelected;
    return data;
  }
}
