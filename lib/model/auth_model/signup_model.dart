class SignupModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? countryId;
  String? stateId;
  String? cityId;
  String? pincode;
  String? postOfficeName;
  String? circle;
  String? district;
  String? division;
  String? region;
  // String? block;
  String? refrredBy;
  String? aniversartDate;
  String? dob;
  String? gender;
  // String? address;
  // String? lat;
  // String? long;
  SignupModel({
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
    // this.block,
    this.aniversartDate,
    this.refrredBy,
    this.dob,
    this.gender,
    // this.lat,
    // this.address,
    // this.long,
  });

  SignupModel.fromJson(Map<String, dynamic> json) {
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
    aniversartDate = json['aniversary_date'];
    refrredBy = json['referred_by'];
    circle = json['circle'];
    district = json['district'];
    division = json['division'];
    region = json['region'];
    // block = json['block'];
    dob = json['dob'];
    gender = json['gender'];
    // lat = json['lat'];
    // long = json['long'];
    // address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['referred_by'] = refrredBy;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['postOfficeName'] = postOfficeName;
    data['aniversary_date'] = aniversartDate;
    data['circle'] = circle;
    data['district'] = district;
    data['division'] = division;
    data['region'] = region;
    data['gender'] = gender;
    // data['block'] = block;
    data['dob'] = dob;
    // data['address'] = address;
    return data;
  }
}
