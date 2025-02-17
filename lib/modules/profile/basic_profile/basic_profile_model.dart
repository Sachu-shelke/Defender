import 'package:flutter/material.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/auth_model/pin_code_model.dart';
import 'package:defenders/model/auth_model/state_model.dart';
import 'package:share_plus/share_plus.dart';

class BasicProfileModel {
  XFile? selectedImages;
  List<States> stateModel;
  List<Cities> cityModel;
  List<PinCodeModelResponse> pinCodeModel;
  States? selectedState;
  Cities? selectedCity;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController pincodeController;
  final TextEditingController joiningDate;
  final TextEditingController authorizationDate;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController dist;
  final TextEditingController state;
  final TextEditingController dob;
  final TextEditingController gender;
  BasicProfileModel({
    this.selectedImages,
    required this.authorizationDate,
    required this.dist,
    required this.stateModel,
    required this.cityModel,
    required this.pinCodeModel,
    this.selectedState,
    this.selectedCity,
    required this.pincodeController,
    required this.stateController,
    required this.cityController,
    required this.dob,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.joiningDate,
    required this.lastName,
    required this.state,
  });
}
