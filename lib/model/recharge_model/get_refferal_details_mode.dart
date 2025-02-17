class GetRefferalDetailsModel {
  int? status;
  String? message;
  RefferalDetailsData? data;
  String? ipAddress;

  GetRefferalDetailsModel(
      {this.status, this.message, this.data, this.ipAddress});

  GetRefferalDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? RefferalDetailsData.fromJson(json['data'])
        : null;
    ipAddress = json['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ipAddress'] = ipAddress;
    return data;
  }
}

class RefferalDetailsData {
  int? id;
  String? name;
  String? mlmId;
  String? mobile;

  RefferalDetailsData({this.id, this.name, this.mlmId, this.mobile});

  RefferalDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mlmId = json['mlm_id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mlm_id'] = mlmId;
    data['mobile'] = mobile;
    return data;
  }
}
