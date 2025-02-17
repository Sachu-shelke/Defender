class EpinHistoryModel {
  int? status;
  String? message;
  List<EpinHistoryModelData>? data;
  int? totalPageCount;

  EpinHistoryModel({this.status, this.message, this.data, this.totalPageCount});

  EpinHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EpinHistoryModelData>[];
      json['data'].forEach((v) {
        data!.add(EpinHistoryModelData.fromJson(v));
      });
    }
    totalPageCount = json['totalPageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalPageCount'] = totalPageCount;
    return data;
  }
}

class EpinHistoryModelData {
  int? id;
  int? userId;
  String? transactionId;
  String? env;
  String? type;
  String? subType;
  int? openingBalance;
  int? credit;
  int? debit;
  int? closingBalance;
  String? tranFor;
  String? status;
  String? createdOn;

  EpinHistoryModelData({
    this.id,
    this.userId,
    this.transactionId,
    this.env,
    this.type,
    this.subType,
    this.openingBalance,
    this.credit,
    this.debit,
    this.closingBalance,
    this.tranFor,
    this.status,
    this.createdOn,
  });

  EpinHistoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    env = json['env'];
    type = json['type'];
    subType = json['sub_type'];
    openingBalance = json['opening_balance'];
    credit = json['credit'];
    debit = json['debit'];
    closingBalance = json['closing_balance'];
    tranFor = json['tran_for'];
    status = json['status'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['env'] = env;
    data['type'] = type;
    data['sub_type'] = subType;
    data['opening_balance'] = openingBalance;
    data['credit'] = credit;
    data['debit'] = debit;
    data['closing_balance'] = closingBalance;
    data['tran_for'] = tranFor;
    data['status'] = status;
    data['created_on'] = createdOn;
    return data;
  }
}
