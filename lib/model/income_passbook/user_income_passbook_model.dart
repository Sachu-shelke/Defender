class UserIncomePassbookModel {
  int? status;
  String? message;
  TotalAmount? totalAmount;
  List<UserIncomePassbookData>? data;

  UserIncomePassbookModel({this.status, this.message, this.data});

  UserIncomePassbookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    totalAmount = TotalAmount.fromJson(json['totalAmount']);
    if (json['data'] != null) {
      data = <UserIncomePassbookData>[];
      json['data'].forEach((v) {
        data!.add(UserIncomePassbookData.fromJson(v));
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

class UserIncomePassbookData {
  int? id;
  String? registrationDate;
  String? username;
  String? name;
  String? mlmId;
  String? mobile;
  String? email;
  String? transactionId;
  String? type;
  String? subType;
  String? openingBalance;
  String? credit;
  String? debit;
  String? closingBalance;
  String? incomeDate;
  String? tranFor;
  String? details;
  int? level;
  String? planName;
  String? senderMobile;
  bool? isDropdown;
  num? amount;

  UserIncomePassbookData(
      {this.id,
      this.registrationDate,
      this.username,
      this.name,
      this.amount,
      this.mlmId,
      this.mobile,
      this.isDropdown = false,
      this.email,
      this.transactionId,
      this.type,
      this.subType,
      this.openingBalance,
      this.senderMobile,
      this.credit,
      this.debit,
      this.closingBalance,
      this.incomeDate,
      this.tranFor,
      this.details,
      this.level,
      this.planName});

  UserIncomePassbookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationDate = json['registration_date'];
    username = json['username'];
    name = json['name'];
    mlmId = json['mlm_id'];
    mobile = json['mobile'];
    amount = json['amount'];
    isDropdown = false;
    email = json['email'];
    transactionId = json['transaction_id'].toString();
    type = json['type'];
    subType = json['sub_type'];
    senderMobile = json['sender_mobile'].toString();
    openingBalance = json['opening_balance'].toString();
    credit = json['credit'].toString();
    debit = json['debit'].toString();
    closingBalance = json['closing_balance'].toString();
    incomeDate = json['income_date'];
    tranFor = json['tran_for'];
    details = json['details'];
    level = json['level'];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['registration_date'] = registrationDate;
    data['username'] = username;
    data['name'] = name;
    data['mlm_id'] = mlmId;
    data['mobile'] = mobile;
    data['email'] = email;
    data['transaction_id'] = transactionId;
    data['type'] = type;
    data['sub_type'] = subType;
    data['opening_balance'] = openingBalance;
    data['credit'] = credit;
    data['debit'] = debit;
    data['closing_balance'] = closingBalance;
    data['income_date'] = incomeDate;
    data['tran_for'] = tranFor;
    data['details'] = details;
    data['level'] = level;
    data['plan_name'] = planName;
    return data;
  }
}

class TotalAmount {
  String? openingBalance;
  String? closingBalance;
  String? totalCredit;
  String? totalDebit;
  String? balanceAmount;

  TotalAmount(
      {this.openingBalance,
      this.closingBalance,
      this.totalCredit,
      this.totalDebit,
      this.balanceAmount});

  TotalAmount.fromJson(Map<String, dynamic> json) {
    openingBalance = json['opening_balance'];
    closingBalance = json['closing_balance'];
    totalCredit = json['total_credit'];
    totalDebit = json['total_debit'];
    balanceAmount = json['balance_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['opening_balance'] = openingBalance;
    data['closing_balance'] = closingBalance;
    data['total_credit'] = totalCredit;
    data['total_debit'] = totalDebit;
    data['balance_amount'] = balanceAmount;
    return data;
  }
}
