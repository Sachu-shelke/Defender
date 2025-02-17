class CheckCashbackModel {
  int? status;
  String? message;
  int? rechargeCount;

  CheckCashbackModel({this.status, this.message});

  CheckCashbackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    rechargeCount = json['recharge_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['recharge_count'] = rechargeCount;
    return data;
  }
}
