class PhonePeRequestModel {
  int? status;
  String? message;
  PhonePeData? data;

  PhonePeRequestModel({this.status, this.message, this.data});

  PhonePeRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PhonePeData.fromJson(json['data']) : null;
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

class PhonePeData {
  int? id;
  // int? userId;
  // num? amount;
  // num? transactionId;
  // num? createdBy;
  String? orderId;
  String? responseStatus;
  // Request? request;

  PhonePeData({
    this.id,
    // this.userId,
    // this.amount,
    // this.transactionId,
    // this.createdBy,
    this.orderId,
    this.responseStatus,
    // this.request
  });

  PhonePeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // userId = json['user_id'];
    // amount = json['amount'];
    // transactionId = json['transaction_id'];
    // createdBy = json['created_by'];
    orderId = json['order_id'];
    responseStatus = json['response_status'];
    // request = json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['user_id'] = userId;
    // data['amount'] = amount;
    // data['transaction_id'] = transactionId;
    // data['created_by'] = createdBy;
    data['order_id'] = orderId;
    data['response_status'] = responseStatus;
    // if (this.request != null) {
    //   data['request'] = this.request!.toJson();
    // }
    return data;
  }
}

// class Request {


// 	Request({});

// 	Request.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }
