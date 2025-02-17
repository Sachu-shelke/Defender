class NotificationModel {
  int? status;
  String? message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<NotificationData>? data;
  int? totalPageCount;

  Data({this.data, this.totalPageCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
    totalPageCount = json['totalPageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalPageCount'] = totalPageCount;
    return data;
  }
}

class NotificationData {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? image;
  String? link;
  int? status;
  int? appId;
  String? entryDatetime;

  NotificationData(
      {this.id,
      this.userId,
      this.title,
      this.body,
      this.image,
      this.link,
      this.status,
      this.appId,
      this.entryDatetime});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    link = json['link'];
    status = json['status'];
    appId = json['app_id'];
    entryDatetime = json['notification_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    data['link'] = link;
    data['status'] = status;
    data['app_id'] = appId;
    data['entry_datetime'] = entryDatetime;
    return data;
  }
}
