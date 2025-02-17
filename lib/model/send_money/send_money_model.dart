class SendMoneyModel {
  int? status;
  String? message;
  Data? data;

  SendMoneyModel({this.status, this.message, this.data});

  SendMoneyModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? fromUserId;
  int? toUserId;
  int? amount;
  int? status;
  String? message;
  String? env;
  int? fromTransactionId;
  int? toTransactionId;
  String? createdOn;
  int? createdBy;
  String? firstName;
  String? lastName;

  Data(
      {this.id,
      this.fromUserId,
      this.toUserId,
      this.amount,
      this.status,
      this.message,
      this.env,
      this.fromTransactionId,
      this.toTransactionId,
      this.createdOn,
      this.createdBy,
      this.firstName,
      this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    amount = json['amount'];
    status = json['status'];
    message = json['message'];
    env = json['env'];
    fromTransactionId = json['from_transaction_id'];
    toTransactionId = json['to_transaction_id'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_user_id'] = fromUserId;
    data['to_user_id'] = toUserId;
    data['amount'] = amount;
    data['status'] = status;
    data['message'] = message;
    data['env'] = env;
    data['from_transaction_id'] = fromTransactionId;
    data['to_transaction_id'] = toTransactionId;
    data['created_on'] = createdOn;
    data['created_by'] = createdBy;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
