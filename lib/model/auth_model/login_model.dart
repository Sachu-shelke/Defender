class LoginModel {
  int? status;
  String? token;
  String? refreshToken;
  String? message;
  LoginData? data;

  LoginModel(
      {this.status, this.refreshToken, this.token, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    refreshToken = json['refreshToken'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  int? id;
  String? firstName;
  String? lastName;
  String? registrationDate;
  String? username;
  String? email;
  String? mobile;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? pincode;
  String? address;
  String? dob;
  String? mlmId;
  String? refmlmId;
  String? refFirstName;
  String? refLastName;
  String? refMobile;
  FlagsObject? flagsObject;
  int? isPrime;

  LoginData(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.mobile,
      this.circle,
      this.district,
      this.division,
      this.region,
      this.registrationDate,
      this.block,
      this.mlmId,
      this.pincode,
      this.address,
      this.refmlmId,
      this.refFirstName,
      this.refLastName,
      this.flagsObject,
      this.refMobile,
      this.isPrime,
      this.dob});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    circle = json['circle'];
    district = json['district'];
    division = json['division'];
    region = json['region'];
    block = json['block'];
    pincode = json['pincode'];
    address = json['address'];
    dob = json['dob'];
    isPrime = json['is_prime'];
    mlmId = json['mlm_id'];
    refmlmId = json['ref_mlm_id'];
    refFirstName = json['ref_first_name'];
    refLastName = json['ref_last_name'];
    refMobile = json['ref_mobile'];
    registrationDate = json['registration_date'];
    flagsObject = json['flagsObject'] != null
        ? FlagsObject.fromJson(json['flagsObject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['registration_date'] = registrationDate;
    data['email'] = email;
    data['mobile'] = mobile;
    data['circle'] = circle;
    data['district'] = district;
    data['division'] = division;
    data['region'] = region;
    data['block'] = block;
    data['pincode'] = pincode;
    data['address'] = address;
    data['dob'] = dob;
    data['mlm_id'] = mlmId;
    if (flagsObject != null) {
      data['flagsObject'] = flagsObject!.toJson();
    }
    return data;
  }
}

class FlagsObject {
  int? hybridPrime;
  int? boosterPrime;
  int? prime;
  int? primeB;

  FlagsObject({this.hybridPrime, this.boosterPrime, this.prime, this.primeB});

  FlagsObject.fromJson(Map<String, dynamic> json) {
    hybridPrime = json['hybrid prime'];
    boosterPrime = json['booster prime'];
    prime = json['prime'];
    primeB = json['prime b'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hybrid prime'] = hybridPrime;
    data['booster prime'] = boosterPrime;
    data['prime'] = prime;
    data['prime b'] = primeB;
    return data;
  }
}
