class RecentRechargeModel {
  int? status;
  String? message;
  List<RecentRechargeData>? data;

  RecentRechargeModel({this.status, this.message, this.data});

  RecentRechargeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecentRechargeData>[];
      json['data'].forEach((v) {
        data!.add(RecentRechargeData.fromJson(v));
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

class RecentRechargeData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? consumerNumber;
  String? rechargeAmount;
  String? rechargeType;
  String? rechargeStatus;
  String? operatorName;
  String? createdOn;
  String? amount;
  String? operatorImage;
  String? txenId;
  String? operatorId;

  RecentRechargeData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.consumerNumber,
    this.rechargeAmount,
    this.operatorImage,
    this.rechargeType,
    this.rechargeStatus,
    this.operatorName,
    this.amount,
    this.createdOn,
    this.txenId,
    this.operatorId,
  });

  RecentRechargeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    consumerNumber = json['ConsumerNumber'];
    rechargeAmount = json['recharge_amount'];
    rechargeType = json['recharge_type'];
    rechargeStatus = json['recharge_status'];
    operatorName = json['operator_name'];
    operatorImage = json['operator_image'];
    createdOn = json['created_on'];
    amount = json['amount'].toString();
    txenId = json['trax_id'].toString();
    operatorId = json['operatorId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['ConsumerNumber'] = consumerNumber;
    data['recharge_amount'] = rechargeAmount;
    data['recharge_type'] = rechargeType;
    data['recharge_status'] = rechargeStatus;
    data['operator_name'] = operatorName;
    data['operator_image'] = operatorImage;
    data['amount'] = amount;
    return data;
  }
}
