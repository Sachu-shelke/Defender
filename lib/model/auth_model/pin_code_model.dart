class PinCodeModel {
  int? status;
  int? code;
  String? description;
  String? message;
  List<PinCodeModelResponse>? response;

  PinCodeModel(
      {this.status, this.code, this.description, this.message, this.response});

  PinCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    description = json['description'];
    message = json['message'];
    if (json['data'] != null) {
      response = <PinCodeModelResponse>[];
      json['data'].forEach((v) {
        response!.add(PinCodeModelResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['description'] = description;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PinCodeModelResponse {
  String? name;
  String? description;
  String? branchType;
  String? deliveryStatus;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? state;
  String? country;
  String? pincode;

  PinCodeModelResponse(
      {this.name,
      this.description,
      this.branchType,
      this.deliveryStatus,
      this.circle,
      this.district,
      this.division,
      this.region,
      this.block,
      this.state,
      this.country,
      this.pincode});

  PinCodeModelResponse.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    branchType = json['BranchType'];
    deliveryStatus = json['DeliveryStatus'];
    circle = json['Circle'];
    district = json['District'];
    division = json['Division'];
    region = json['Region'];
    block = json['Block'];
    state = json['State'];
    country = json['Country'];
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Description'] = description;
    data['BranchType'] = branchType;
    data['DeliveryStatus'] = deliveryStatus;
    data['Circle'] = circle;
    data['District'] = district;
    data['Division'] = division;
    data['Region'] = region;
    data['Block'] = block;
    data['State'] = state;
    data['Country'] = country;
    data['Pincode'] = pincode;
    return data;
  }
}
