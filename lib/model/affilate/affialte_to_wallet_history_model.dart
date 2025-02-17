class AffiliateToWalletHistroyModel {
  int? status;
  String? message;
  List<AffiliateToWalletHistroyData>? data;

  AffiliateToWalletHistroyModel({this.status, this.message, this.data});

  AffiliateToWalletHistroyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AffiliateToWalletHistroyData>[];
      json['data'].forEach((v) {
        data!.add(AffiliateToWalletHistroyData.fromJson(v));
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

class AffiliateToWalletHistroyData {
  num? id;
  num? userId;
  num? amount;
  num? deductionAmt;
  num? transferAmt;
  num? status;
  String? category;
  String? transNo;

  String? createdOn;
  String? mlmId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? tranferDate;

  AffiliateToWalletHistroyData(
      {this.id,
      this.userId,
      this.amount,
      this.deductionAmt,
      this.transferAmt,
      this.status,
      this.category,
      this.transNo,
      this.createdOn,
      this.mlmId,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.tranferDate});

  AffiliateToWalletHistroyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    deductionAmt = json['deduction_amt'];
    transferAmt = json['transfer_amt'];
    status = json['status'];
    category = json['category'];
    transNo = json['trans_no'];

    createdOn = json['created_on'];

    mlmId = json['mlm_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    tranferDate = json['tranfer_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['deduction_amt'] = deductionAmt;
    data['transfer_amt'] = transferAmt;
    data['status'] = status;
    data['category'] = category;
    data['trans_no'] = transNo;

    data['created_on'] = createdOn;
    data['mlm_id'] = mlmId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['tranfer_date'] = tranferDate;
    return data;
  }
}
