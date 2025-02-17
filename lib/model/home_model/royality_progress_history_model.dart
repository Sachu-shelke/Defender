class UserLogDateHistoryModel {
  int? status;
  String? message;
  List<UserLogDateHistory>? data;

  UserLogDateHistoryModel({this.status, this.message, this.data});

  UserLogDateHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserLogDateHistory>[];
      json['data'].forEach((v) {
        data!.add(UserLogDateHistory.fromJson(v));
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

class UserLogDateHistory {
  String? task;
  int? targetCount;
  int? taskCount;
  String? taskStatus;

  UserLogDateHistory(
      {this.task, this.targetCount, this.taskCount, this.taskStatus});

  UserLogDateHistory.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    targetCount = json['target_count'];
    taskCount = json['task_count'];
    taskStatus = json['task_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['target_count'] = targetCount;
    data['task_count'] = taskCount;
    data['task_status'] = taskStatus;
    return data;
  }
}
