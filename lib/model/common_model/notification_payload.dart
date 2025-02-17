class NotificationPayload {
  String? type;
  String? title;
  String? messege;
  String? imageUrl;
  String? urlName;
  String? category;

  NotificationPayload(
      {this.type, this.title, this.messege, this.imageUrl, this.urlName});

  NotificationPayload.fromJson(Map<String, dynamic> json) {
    type = json["notification_type"] ?? '';
    title = json["title"] ?? '';
    category = json["category"] ?? '';
    messege = json["body"] ?? '';
    imageUrl = json["image"] ?? '';
    urlName = json["link"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["notification_type"] = type;
    data["title"] = title;
    data["body"] = messege;
    data["image"] = imageUrl;
    data["link"] = urlName;
    return data;
  }
}
