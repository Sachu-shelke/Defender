class WalletPassbookDataModel {
  int? status;
  String? message;
  List<WalletPassbookDataModelData>? data;
  int? totalPageCount;

  WalletPassbookDataModel({this.status, this.message, this.data});

  WalletPassbookDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalPageCount = json['totalPageCount'];
    if (json['data'] != null) {
      data = <WalletPassbookDataModelData>[];
      json['data'].forEach((v) {
        data!.add(WalletPassbookDataModelData.fromJson(v));
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

class WalletPassbookDataModelData {
  int? id;
  int? refTblId;
  int? userId;
  String? transactionId;
  String? env;
  String? type;
  String? openingBalance;
  String? credit;
  String? debit;
  String? closingBalance;
  String? tranFor;
  String? spinOutcome;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? deletedOn;
  String? deletedBy;
  String? consumerNumber;
  String? rechargeType;
  dynamic mainAmount;
  String? serviceRate;
  String? serviceAmount;
  dynamic cashbackAmount;
  dynamic cashbackRate;
  String? description;
  String? panel;
  String? operator;
  String? fromUserFirstName;
  String? fromUserLastName;
  String? fromUserMobile;
  String? toUserFirstName;
  String? toUserLastName;
  String? toUserMobile;
  String? subType;
  String? operatorImage;
  String? traxId;
  String? referenceNo;
  String? cashbackPoint;
  String? bonusPoint;
  String? rechargeStatus;
  String? planName;

  WalletPassbookDataModelData({
    this.id,
    this.refTblId,
    this.cashbackPoint,
    this.userId,
    this.transactionId,
    this.planName,
    this.env,
    this.type,
    this.openingBalance,
    this.credit,
    this.debit,
    this.closingBalance,
    this.tranFor,
    // this.status,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
    this.deletedOn,
    this.deletedBy,
    this.consumerNumber,
    this.rechargeType,
    this.mainAmount,
    this.serviceRate,
    this.serviceAmount,
    this.cashbackAmount,
    this.cashbackRate,
    this.description,
    this.panel,
    this.operator,
    this.fromUserFirstName,
    this.fromUserLastName,
    this.fromUserMobile,
    this.toUserFirstName,
    this.operatorImage,
    this.toUserLastName,
    this.toUserMobile,
    this.subType,
    this.traxId,
    this.referenceNo,
    this.bonusPoint,
    this.rechargeStatus,
  });

  WalletPassbookDataModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refTblId = json['ref_tbl_id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'].toString();
    cashbackPoint = json['cashback_point'].toString();
    bonusPoint = json['bonus_point'].toString();
    env = json['env'];
    spinOutcome = json['spin_outcome'];
    type = json['type'];
    openingBalance = json['opening_balance'].toString();
    credit = json['credit'].toString();
    debit = json['debit'].toString();
    closingBalance = json['closing_balance'].toString();
    tranFor = json['tran_for'];
    // status = json['status'];
    createdOn = json['created_on'];
    createdBy = json['created_by'].toString();
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];
    operatorImage = json['operator_image'];
    deletedOn = json['deleted_on'];
    deletedBy = json['deleted_by'];
    consumerNumber = json['consumer_number'];
    rechargeType = json['recharge_type'];
    subType = json['sub_type'];
    mainAmount = json['main_amount'];
    serviceRate = json['service_rate'];
    serviceAmount = json['service_amount'];
    cashbackAmount = json['cashback_amount'];
    cashbackRate = json['cashback_rate'];
    description = json['description'];
    planName = json['plan_name'];
    panel = json['panel'];
    operator = json['operator'];
    fromUserFirstName = json['from_user_fname'];
    fromUserLastName = json['from_user_lname'];
    fromUserMobile = json['from_user_mobile'];
    toUserFirstName = json['to_user_fname'];
    toUserLastName = json['to_user_lname'];
    toUserMobile = json['to_user_mobile'];
    traxId = json['trax_id'];
    referenceNo = json['reference_no'];
    rechargeStatus = json['recharge_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_tbl_id'] = refTblId;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['env'] = env;
    data['type'] = type;
    data['opening_balance'] = openingBalance;
    data['credit'] = credit;
    data['debit'] = debit;
    data['closing_balance'] = closingBalance;
    data['tran_for'] = tranFor;
    // data['status'] = status;
    data['created_on'] = createdOn;
    data['created_by'] = createdBy;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;
    data['deleted_on'] = deletedOn;
    data['deleted_by'] = deletedBy;
    data['trax_id'] = traxId;
    return data;
  }
}
