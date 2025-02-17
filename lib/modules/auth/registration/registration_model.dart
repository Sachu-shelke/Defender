import 'package:flutter/material.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/auth_model/pin_code_model.dart';
import 'package:defenders/model/auth_model/state_model.dart';
import 'package:defenders/model/recharge_model/get_refferal_details_mode.dart';

class RegistrationModel {
  List<States> stateModel;
  List<Cities> cityModel;
  List<PinCodeModelResponse> pinCodeModel;
  States? selectedState;
  Cities? selectedCity;

  TextEditingController? firstnameController;
  TextEditingController? lastnameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? phoneController;
  TextEditingController? referCodeController;
  TextEditingController? stateController;
  TextEditingController? cityController;
  TextEditingController? pincodeController;
  TextEditingController? addressController;
  TextEditingController? blockController;
  RefferalDetailsData? refferalDetaisl;
  bool dontHaveReffere;

  bool isCityLoader;

  RegistrationModel(
      {required this.stateModel,
      required this.cityModel,
      required this.pinCodeModel,
      this.selectedState,
      this.dontHaveReffere = false,
      this.selectedCity,
      this.pincodeController,
      this.isCityLoader = false,
      this.cityController,
      this.emailController,
      this.firstnameController,
      this.lastnameController,
      this.passwordController,
      this.addressController,
      this.blockController,
      this.phoneController,
      this.referCodeController,
      this.stateController});
}
