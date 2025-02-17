class GetRewardPassbookModel {
  int? status;
  String? message;
  List<GetRewardPassbookData>? data;

  GetRewardPassbookModel({this.status, this.message, this.data});

  GetRewardPassbookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetRewardPassbookData>[];
      json['data'].forEach((v) {
        data!.add(GetRewardPassbookData.fromJson(v));
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

class GetRewardPassbookData {
  num? id;
  num? userId;
  String? spinnerId;
  String? spinDate;
  String? spinOutcome;
  num? mainAmount;
  num? cashbackAmount;
  String? createdOn;
  num? attempt;
  String? cashbackType;

  GetRewardPassbookData(
      {this.id,
      this.userId,
      this.spinnerId,
      this.spinDate,
      this.spinOutcome,
      this.mainAmount,
      this.cashbackAmount,
      this.createdOn,
      this.attempt,
      this.cashbackType});

  GetRewardPassbookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    spinnerId = json['spinner_id'];
    spinDate = json['spin_date'];
    spinOutcome = json['spin_outcome'];
    mainAmount = json['main_amount'];
    cashbackAmount = json['cashback_amount'];
    createdOn = json['created_on'];
    attempt = json['attempt'];
    cashbackType = json['cashback_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['spinner_id'] = spinnerId;
    data['spin_date'] = spinDate;
    data['spin_outcome'] = spinOutcome;
    data['main_amount'] = mainAmount;
    data['cashback_amount'] = cashbackAmount;
    data['created_on'] = createdOn;
    data['attempt'] = attempt;
    data['cashback_type'] = cashbackType;
    return data;
  }
}
