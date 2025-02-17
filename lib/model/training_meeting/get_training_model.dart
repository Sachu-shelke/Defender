class GetTrainingModel {
  int? status;
  String? message;
  List<GetTrainingData>? data;

  GetTrainingModel({this.status, this.message, this.data});

  GetTrainingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetTrainingData>[];
      json['data'].forEach((v) {
        data!.add(GetTrainingData.fromJson(v));
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

class GetTrainingData {
  int? id;
  String? name;
  String? description;
  String? meetingDate;
  String? meetingTime;
  String? meetingLink;
  String? image;
  String? createdBy;
  int? status;
  String? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  int? isInvite;
  int? isEnroll;
  int? isJoin;
  int? totalJoin;
  int? totalEnroll;
  int? totalInvite;

  GetTrainingData(
      {this.id,
      this.name,
      this.description,
      this.meetingDate,
      this.meetingTime,
      this.meetingLink,
      this.image,
      this.createdBy,
      this.status,
      this.modifiedBy,
      this.createdOn,
      this.modifiedOn,
      this.isInvite,
      this.isEnroll,
      this.totalJoin,
      this.totalEnroll,
      this.totalInvite,
      this.isJoin});

  GetTrainingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    meetingDate = json['meeting_date'];
    meetingTime = json['meeting_time'];
    meetingLink = json['meeting_link'];
    image = json['image'];
    createdBy = json['created_by'];
    status = json['status'];
    modifiedBy = json['modified_by'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    isInvite = json['is_invite'];
    isEnroll = json['is_enroll'];
    isJoin = json['is_join'];
    totalEnroll = json['total_enroll'];
    totalInvite = json['total_invite'];
    totalJoin = json['total_join'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['meeting_date'] = meetingDate;
    data['meeting_time'] = meetingTime;
    data['meeting_link'] = meetingLink;
    data['image'] = image;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['modified_by'] = modifiedBy;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['is_invite'] = isInvite;
    data['is_enroll'] = isEnroll;
    data['is_join'] = isJoin;
    return data;
  }
}
