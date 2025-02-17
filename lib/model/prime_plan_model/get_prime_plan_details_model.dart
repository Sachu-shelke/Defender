class GetPrimePlanDetailsModel {
  int? status;
  String? message;
  List<GetPrimePlanDetailsData>? data;

  GetPrimePlanDetailsModel({this.status, this.message, this.data});

  GetPrimePlanDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetPrimePlanDetailsData>[];
      json['data'].forEach((v) {
        data!.add(GetPrimePlanDetailsData.fromJson(v));
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

class GetPrimePlanDetailsData {
  int? id;
  String? planName;
  String? planAmount;
  String? gst;
  String? withoutGst;
  List<String>? planDetails;

  GetPrimePlanDetailsData(
      {this.id,
      this.planName,
      this.planAmount,
      this.gst,
      this.withoutGst,
      this.planDetails});

  GetPrimePlanDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    planAmount = json['plan_amount'];
    gst = json['gst'];
    withoutGst = json['without_gst'];
    planDetails = json['plan_details'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_name'] = planName;
    data['plan_amount'] = planAmount;
    data['gst'] = gst;
    data['without_gst'] = withoutGst;
    data['plan_details'] = planDetails;
    return data;
  }
}
