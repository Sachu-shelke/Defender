class AddMoneyManualHistoryModel {
  int? status;
  String? message;
  List<AddMoneyManualHistoryData>? data;

  AddMoneyManualHistoryModel({this.status, this.message, this.data});

  AddMoneyManualHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddMoneyManualHistoryData>[];
      json['data'].forEach((v) {
        data!.add(AddMoneyManualHistoryData.fromJson(v));
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

class AddMoneyManualHistoryData {
  int? id;
  int? userId;
  int? amount;
  int? status;
  String? category;
  String? transNo;
  String? img;
  int? amrAw;
  String? rejectionReason;
  String? createdOn;
  String? updatedOn;

  String? firstName;
  String? lastName;
  String? username;
  String? mobile;
  String? requestDate;

  AddMoneyManualHistoryData(
      {this.id,
      this.userId,
      this.amount,
      this.status,
      this.category,
      this.transNo,
      this.img,
      this.amrAw,
      this.rejectionReason,
      this.createdOn,
      this.updatedOn,
      this.firstName,
      this.lastName,
      this.username,
      this.mobile,
      this.requestDate});

  AddMoneyManualHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    status = json['status'];
    category = json['category'];
    transNo = json['trans_no'];
    img = json['img'];
    amrAw = json['amr_aw'];
    rejectionReason = json['rejection_reason'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    mobile = json['mobile'];
    requestDate = json['request_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['status'] = status;
    data['category'] = category;
    data['trans_no'] = transNo;
    data['img'] = img;
    data['amr_aw'] = amrAw;
    data['rejection_reason'] = rejectionReason;
    data['created_on'] = createdOn;
    data['updated_on'] = updatedOn;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['mobile'] = mobile;
    data['request_date'] = requestDate;
    return data;
  }
}
