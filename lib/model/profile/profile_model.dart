class ProfileScreenModel {
  int? status;
  String? message;
  num? totalCashback;
  num? totalReferral;
  List<ProfileData>? data;

  ProfileScreenModel(
      {this.status,
      this.totalCashback,
      this.totalReferral,
      this.message,
      this.data});

  ProfileScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalCashback = json['total_cashback'];
    totalReferral = json['total_referral'];
    if (json['data'] != null) {
      data = <ProfileData>[];
      json['data'].forEach((v) {
        data!.add(ProfileData.fromJson(v));
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

class ProfileData {
  int? id;
  int? referredBy;
  String? mlmId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  String? password;
  int? countryId;
  int? stateId;
  int? cityId;
  String? pincode;
  String? postOfficeName;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? dob;
  String? planName;
  String? planAmount;
  String? address;
  String? profilePic;
  int? status;
  String? createdOn;
  String? modifiedOn;
  int? modifiedBy;
  String? refMlmId;
  String? refFirstName;
  String? refLastName;
  String? refUsername;
  String? refEmail;
  String? refMobile;
  String? refDob;

  int? isPrime;
  FlagsObject? flagsObject;

  ProfileData(
      {this.id,
      this.referredBy,
      this.mlmId,
      this.profilePic,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.mobile,
      this.password,
      this.countryId,
      this.stateId,
      this.cityId,
      this.pincode,
      this.postOfficeName,
      this.circle,
      this.district,
      this.division,
      this.region,
      this.block,
      this.dob,
      this.planName,
      this.planAmount,
      this.address,
      this.status,
      this.createdOn,
      this.modifiedOn,
      this.modifiedBy,
      this.refMlmId,
      this.refFirstName,
      this.refLastName,
      this.refUsername,
      this.refEmail,
      this.refMobile,
      this.refDob,
      this.isPrime,
      this.flagsObject});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referredBy = json['referred_by'];
    profilePic = json['profile_pic'];
    mlmId = json['mlm_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    postOfficeName = json['postOfficeName'];
    circle = json['circle'];
    district = json['district'];
    division = json['division'];
    region = json['region'];
    block = json['block'];
    dob = json['dob'];
    planName = json['plan_name'];
    planAmount = json['plan_amount'];

    address = json['address'];

    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];

    refMlmId = json['ref_mlm_id'];
    refFirstName = json['ref_first_name'];
    refLastName = json['ref_last_name'];
    refUsername = json['ref_username'];
    refEmail = json['ref_email'];
    refMobile = json['ref_mobile'];
    refDob = json['ref_dob'];

    isPrime = json['is_prime'];
    flagsObject = json['flagsObject'] != null
        ? FlagsObject.fromJson(json['flagsObject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referred_by'] = referredBy;
    data['mlm_id'] = mlmId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['postOfficeName'] = postOfficeName;
    data['circle'] = circle;
    data['district'] = district;
    data['division'] = division;
    data['region'] = region;
    data['block'] = block;
    data['dob'] = dob;
    data['plan_name'] = planName;
    data['plan_amount'] = planAmount;

    data['address'] = address;

    data['status'] = status;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;

    data['ref_mlm_id'] = refMlmId;
    data['ref_first_name'] = refFirstName;
    data['ref_last_name'] = refLastName;
    data['ref_username'] = refUsername;
    data['ref_email'] = refEmail;
    data['ref_mobile'] = refMobile;
    data['ref_dob'] = refDob;

    data['is_prime'] = isPrime;
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
