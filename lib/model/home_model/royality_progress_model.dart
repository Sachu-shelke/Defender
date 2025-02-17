// class RoyalityProgressModel {
//   int? status;
//   String? message;
//   num? totalTaskdone;
//   List<RoyalityProgressData>? data;

//   RoyalityProgressModel(
//       {this.status, this.totalTaskdone, this.message, this.data});

//   RoyalityProgressModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     totalTaskdone = json['totalTaskdone'];
//     if (json['data'] != null) {
//       data = <RoyalityProgressData>[];
//       json['data'].forEach((v) {
//         data!.add(RoyalityProgressData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     data['totalTaskdone'] = totalTaskdone;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class RoyalityProgressData {
//   String? task;
//   int? targetCount;
//   int? countTUserId;

//   RoyalityProgressData({this.task, this.targetCount, this.countTUserId});

//   RoyalityProgressData.fromJson(Map<String, dynamic> json) {
//     task = json['task'];
//     targetCount = json['target_count'];
//     countTUserId = json['task_count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['task'] = task;
//     data['target_count'] = targetCount;
//     data['task_count'] = countTUserId;
//     return data;
//   }
// }

class RoyalityProgressModel {
  num? status;
  String? message;
  List<RoyalityProgressData>? data;
  List<TotalTaskdone>? totalTaskdone;
  List<Activetask>? activetask;

  RoyalityProgressModel(
      {this.status,
      this.message,
      this.data,
      this.totalTaskdone,
      this.activetask});

  RoyalityProgressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RoyalityProgressData>[];
      json['data'].forEach((v) {
        data!.add(RoyalityProgressData.fromJson(v));
      });
    }
    if (json['totalTaskdone'] != null) {
      totalTaskdone = <TotalTaskdone>[];
      json['totalTaskdone'].forEach((v) {
        totalTaskdone!.add(TotalTaskdone.fromJson(v));
      });
    }
    if (json['activetask'] != null) {
      activetask = <Activetask>[];
      json['activetask'].forEach((v) {
        activetask!.add(Activetask.fromJson(v));
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
    if (totalTaskdone != null) {
      data['totalTaskdone'] = totalTaskdone!.map((v) => v.toJson()).toList();
    }
    if (activetask != null) {
      data['activetask'] = activetask!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoyalityProgressData {
  String? task;
  num? targetCount;
  num? taskCount;

  RoyalityProgressData({this.task, this.targetCount, this.taskCount});

  RoyalityProgressData.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    targetCount = json['target_count'];
    taskCount = json['task_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['target_count'] = targetCount;
    data['task_count'] = taskCount;
    return data;
  }
}

class TotalTaskdone {
  String? percentage;

  TotalTaskdone({this.percentage});

  TotalTaskdone.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    return data;
  }
}

class Activetask {
  num? total;

  Activetask({this.total});

  Activetask.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    return data;
  }
}
