class RedeemHistoryModel {
  int? status;
  String? message;
  List<RedeemHistorData>? data;

  RedeemHistoryModel({this.status, this.message, this.data});

  RedeemHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RedeemHistorData>[];
      json['data'].forEach((v) {
        data!.add(RedeemHistorData.fromJson(v));
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

class RedeemHistorData {
  int? id;
  int? userId;
  int? amount;
  String? category;
  String? remarks;
  String? transNo;
  String? approvalRemarks;
  int? updatedBy;
  int? status;
  String? createdOn;
  String? redeemDate;

  RedeemHistorData(
      {this.id,
      this.userId,
      this.amount,
      this.category,
      this.remarks,
      this.transNo,
      this.approvalRemarks,
      this.updatedBy,
      this.status,
      this.createdOn,
      this.redeemDate});

  RedeemHistorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    category = json['category'];
    remarks = json['remarks'];
    transNo = json['trans_no'];
    approvalRemarks = json['approval_remarks'];
    updatedBy = json['updated_by'];
    status = json['status'];
    createdOn = json['created_on'];
    redeemDate = json['redeem_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['category'] = category;
    data['remarks'] = remarks;
    data['trans_no'] = transNo;
    data['approval_remarks'] = approvalRemarks;
    data['updated_by'] = updatedBy;
    data['status'] = status;
    data['created_on'] = createdOn;
    data['redeem_date'] = redeemDate;
    return data;
  }
}
