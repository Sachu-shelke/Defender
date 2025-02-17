// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/encryption/encryption.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/auth_model/pin_code_model.dart';
import 'package:defenders/model/auth_model/state_model.dart';
import 'package:defenders/modules/profile/basic_profile/basic_profile_model.dart';
import 'package:defenders/modules/profile/basic_profile/basic_profile_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/snackbar/snackbars.dart';

class BasicProfilePresenter {
  Future<void> getState(
      {required String countryId, BuildContext? context}) async {}
  Future<void> getCity(
      {required String stateId, BuildContext? context}) async {}
  Future<void> getPinCode(
      {required String pinCode, BuildContext? context}) async {}
  Future<void> addProfile({required BuildContext context}) async {}
  set updateView(BasicProfileView kycView) {}
}

class BasicBasicProfilePresenter implements BasicProfilePresenter {
  late BasicProfileView view;
  late BasicProfileModel model;

  BasicBasicProfilePresenter() {
    view = BasicProfileView();
    model = BasicProfileModel(
      cityModel: [],
      pinCodeModel: [],
      stateModel: [],
      pincodeController: TextEditingController(),
      cityController: TextEditingController(),
      stateController: TextEditingController(),
      authorizationDate: TextEditingController(),
      dist: TextEditingController(),
      dob: TextEditingController(),
      email: TextEditingController(),
      firstName: TextEditingController(),
      gender: TextEditingController(),
      joiningDate: TextEditingController(),
      lastName: TextEditingController(),
      state: TextEditingController(),
    );
  }

  @override
  Future<void> addProfile({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.updateProfile,
      context: context,
      isEncryptionUse: true,
      data: FormData.fromMap(
        {
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
          'instagram_id': '',
          'first_name': model.firstName.text,
          'last_name': model.lastName.text,
          "pincode": model.pincodeController.text,

          "circle": model.cityController.text,

          "division": model.stateController.text,

          "district": model.stateController.text,

          "region": model.stateController.text,
          // if (model.selectedCity != null) 'district': model.selectedCity!.name,
          // if (model.selectedState != null) 'circle': model.selectedState!.name,
          // if (model.selectedState != null) "state_id": model.selectedState!.id,
          // if (model.selectedCity != null) "city_id": model.selectedCity!.id,
          'dob': model.dob.text,
          'gender': model.gender.text,
          'img': model.selectedImages != null
              ? await MultipartFile.fromFile(
                  model.selectedImages!.path,
                  filename: 'deposit.jpg',
                )
              : null,
        },
      ),
    );
    if (response != null && response['status'] == 200) {
      GlobalSingleton.loginInfo!.data!.firstName = model.firstName.text;
      GlobalSingleton.loginInfo!.data!.lastName = model.lastName.text;
      GlobalSingleton.loginInfo!.data!.circle = model.state.text;
      GlobalSingleton.loginInfo!.data!.dob = model.dob.text;
      StorageManager.setStringValue(
        key: 'data',
        value: encrypt(
          text: jsonEncode(GlobalSingleton.loginInfo),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.successSnackBar(title: 'Profile Update successfully'));
      context.router.push(MainHomeScreenRoute(isFromSignup: false));
      view.refreshModel(model);
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

        model.cityController.text = model.pinCodeModel.first.district!;
        model.stateController.text = model.pinCodeModel.first.circle!;
        view.refreshModel(model);
      }
    }
  }

  @override
  set updateView(BasicProfileView kycView) {
    view = kycView;
    view.refreshModel(model);
  }
}
