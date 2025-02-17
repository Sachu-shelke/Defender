class OperatorListModel {
  int? status;
  String? message;
  List<OperatorListModelData>? data;
  List<String>? circle;

  OperatorListModel({this.status, this.message, this.data});

  OperatorListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['circle'] != null) {
      circle = [];
      json['circle'].forEach((v) {
        circle!.add(v.toString());
      });
    }
    if (json['data'] != null) {
      data = <OperatorListModelData>[];
      json['data'].forEach((v) {
        data!.add(OperatorListModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['circle'] = circle;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OperatorListModelData {
  int? id;
  String? operatorName;
  String? description;
  String? image;
  String? category;
  String? billerId;

  int? status;
  OperatorListModelData({
    this.id,
    this.operatorName,
    this.description,
    this.image,
    this.category,
    this.status,
    this.billerId,
  });

  OperatorListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operatorName = json['operator_name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    status = json['status'];
    billerId = json['biller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['operator_name'] = operatorName;
    data['description'] = description;
    data['image'] = image;
    data['category'] = category;
    data['status'] = status;
    data['biller_id'] = billerId;

    return data;
  }
}
