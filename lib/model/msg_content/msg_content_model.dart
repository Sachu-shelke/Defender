class GetMsgCotentModel {
  int? status;
  String? message;
  GetMsgCotentData? data;

  GetMsgCotentModel({this.status, this.message, this.data});

  GetMsgCotentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetMsgCotentData.fromJson(json['data']) : null;
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

class GetMsgCotentData {
  int? id;
  String? body;
  String? title;
  int? status;
  String? createdOn;
  int? createdBy;

  GetMsgCotentData(
      {this.id,
      this.body,
      this.title,
      this.status,
      this.createdOn,
      this.createdBy});

  GetMsgCotentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    status = json['status'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['title'] = title;
    data['status'] = status;
    data['created_on'] = createdOn;
    data['created_by'] = createdBy;
    return data;
  }
}
