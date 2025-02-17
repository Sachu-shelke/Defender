// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:defenders/config/encryption/encryption.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/constants/app_storage_key.dart';
import 'package:defenders/main.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/model/auth_model/pin_code_model.dart';
import 'package:defenders/model/auth_model/signup_model.dart';
import 'package:defenders/model/auth_model/state_model.dart';
import 'package:defenders/model/recharge_model/get_refferal_details_mode.dart';
import 'package:defenders/modules/auth/registration/registration_model.dart';
import 'package:defenders/modules/auth/registration/registration_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/utils/progress_indicator.dart';

class RegistrationPresenter {
  Future<void> register(
      {required SignupModel model, required BuildContext context}) async {}
  Future<void> getRefferBy(
      {required String mlmId, required BuildContext context}) async {}
  Future<void> getState(
      {required String countryId, BuildContext? context}) async {}
  Future<void> getCity(
      {required String stateId, BuildContext? context}) async {}
  Future<void> getPinCode(
      {required String pinCode, BuildContext? context}) async {}
  set registrationView(RegistrationView value) {}
}

class BasicRegistrationPresenter implements RegistrationPresenter {
  late RegistrationModel model;
  late RegistrationView view;
  BasicRegistrationPresenter() {
    view = RegistrationView();
    model = RegistrationModel(
        addressController: TextEditingController(),
        cityController: TextEditingController(),
        emailController: TextEditingController(),
        firstnameController: TextEditingController(),
        lastnameController: TextEditingController(),
        passwordController: TextEditingController(),
        blockController: TextEditingController(),
        referCodeController: TextEditingController(),
        phoneController: TextEditingController(),
        pincodeController: TextEditingController(),
        stateController: TextEditingController(),
        stateModel: [],
        cityModel: [],
        pinCodeModel: []);
  }
  @override
  Future<void> register(
      {required SignupModel model, required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.register,
        data: model.toJson(),
        context: context);
    if (response != null && response['status'] == 200) {
      LoginModel loginModel = LoginModel.fromJson(response);
      GlobalSingleton.loginInfo = loginModel;
      StorageManager.setStringValue(
        key: 'data',
        value: encrypt(
          text: jsonEncode(GlobalSingleton.loginInfo),
        ),
      );
      // await NetworkDio.setDynamicHeader(
      //   authorizationToken: GlobalSingleton.loginInfo!.token.toString(),
      // );
      StorageManager.setBoolValue(key: AppStorageKey.isLogIn, value: true);
      appRouter.pushAndPopUntil(
          PinCodeOtpRoute(isSignup: true, isSplash: false),
          predicate: (roiute) => false);
    }
  }

  @override
  Future<void> getState(
      {required String countryId,
      String? statename,
      String? cityName,
      BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.state,
        data: {
          if (statename == null) "country_id": "101",
          if (statename != null) "state_name": statename
        },
        context: context);

    if (response != null && response['status'] == 200) {
      StateModel stateModel = StateModel.fromJson(response);
      if (stateModel.data != null) {
        model.stateModel = stateModel.data!.first.states!;
        getCity(
            stateId: model.stateModel.first.id.toString(),
            cityName: cityName,
            context: context);
        view.refreshModel(model);
      }
    }
  }

  @override
  Future<void> getRefferBy(
      {required String mlmId, required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.refferBy,
        data: {"mlm_id": mlmId},
        context: context);

    if (response != null && response['status'] == 200) {
      model.refferalDetaisl = GetRefferalDetailsModel.fromJson(response).data;
      if (model.refferalDetaisl!.id != null) {
      } else {
        model.refferalDetaisl = null;
      }
      view.refreshModel(model);
    }
  }

  @override
  Future<void> getCity(
      {required String stateId,
      String? cityName,
      BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.city,
        data: {
          "state_id": stateId,
          if (cityName != null) 'district': cityName,
          'country_id': '101'
        },
        context: context);
    if (response != null && response['status'] == 200) {
      GetCityModel cityModel = GetCityModel.fromJson(response);
      if (cityModel.data != null) {
        model.cityModel = cityModel.data!.first.cities!;
        view.refreshModel(model);
      }
    }
  }

  Circle circle = Circle();
  @override
  Future<void> getPinCode(
      {required String pinCode, BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.pinCode,
        data: {
          "pincode": pinCode,
        },
        context: context);
    if (response != null && response['status'] == 200) {
      PinCodeModel pinCodeModel = PinCodeModel.fromJson(response);
      if (pinCodeModel.response != null) {
        model.pinCodeModel = pinCodeModel.response!;
        // model.selectedState = model.stateModel.firstWhere(
        //   (element) =>
        //       element.name.toString().toLowerCase() ==
        //       model.pinCodeModel.first.circle!.toLowerCase(),
        getState(
            countryId: '101',
            statename: model.pinCodeModel.first.circle!,
            cityName: model.pinCodeModel.first.district,
            context: context);
        // );

        // getCity(
        //     stateId: model.selectedState!.id.toString(),
        //     cityName: model.pinCodeModel.first.district,
        //     context: context);

        model.cityController!.text = model.pinCodeModel.first.district!;
        model.stateController!.text = model.pinCodeModel.first.circle!;
        view.refreshModel(model);
      }
    }
  }

  @override
  set registrationView(
    RegistrationView value,
  ) {
    view = value;
    view.refreshModel(model);
  }
}
