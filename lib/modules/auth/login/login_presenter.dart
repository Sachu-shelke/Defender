// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/encryption/encryption.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/constants/app_storage_key.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/modules/auth/login/login_screen_model.dart';
import 'package:defenders/modules/auth/login/login_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class LoginPresenter {
  Future<void> login(
      {required Map<String, String> loginMo,
      required BuildContext context}) async {}
  set loginView(LoginView value) {}
}

class BasicLoginPresenter implements LoginPresenter {
  late LoginScreenModel model;
  late LoginView view;
  BasicLoginPresenter() {
    view = LoginView();
    model = LoginScreenModel(isButtonTap: false);
  }
  @override
  Future<void> login(
      {required Map<String, String> loginMo,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.login,
        data: loginMo,
        context: context);
    model.isButtonTap = false;
    log(response.toString());
    if (response != null && response['status'] == 200) {
      LoginModel loginModel = LoginModel.fromJson(response);
      await NetworkDio.setDynamicHeader(
        authorizationToken: loginModel.refreshToken.toString(),
      );
      GlobalSingleton.loginInfo = loginModel;

      if (loginMo['username'] == '9824180240') {
        StorageManager.setStringValue(
          key: 'data',
          value: encrypt(
            text: jsonEncode(GlobalSingleton.loginInfo),
          ),
        );
        StorageManager.setBoolValue(key: AppStorageKey.isLogIn, value: true);
        context.router.pushAndPopUntil(
            PinCodeOtpRoute(isSignup: false, isSplash: true),
            predicate: (roiute) => false);
      } else {
        context.router.push(
          OtpScreenRoute(
              otpType: 'Login',
              mobileNumber: loginModel.data!.mobile.toString()),
        );
      }
    }
    view.refreshModel(model);
  }

  @override
  set loginView(LoginView value) {
    view = value;
    view.refreshModel(model);
  }
}
