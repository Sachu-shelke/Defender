class UserAdditionalInfoModel {
  int? status;
  String? message;
  UserAdditionalInfoModelData? data;

  UserAdditionalInfoModel({this.status, this.message, this.data});

  UserAdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? UserAdditionalInfoModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserAdditionalInfoModelData {
  int? isGender;
  int? isProfile;
  int? isInterest;

  UserAdditionalInfoModelData({this.isGender, this.isProfile, this.isInterest});

  UserAdditionalInfoModelData.fromJson(Map<String, dynamic> json) {
    isGender = json['is_gender'];
    isProfile = json['is_profile'];
    isInterest = json['is_interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_gender'] = isGender;
    data['is_profile'] = isProfile;
    data['is_interest'] = isInterest;
    return data;
  }
}
