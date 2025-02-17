// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/modules/auth/forget_password/create_password/create_password_model.dart';
import 'package:defenders/modules/auth/forget_password/create_password/create_password_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class CreatePasswordPresenter {
  Future<void> createPassword(
      {required String password,
      required String mobile,
      required String confirmPassword,
      required BuildContext context}) async {}
  set createPasswordView(CreatePasswordView value) {}
}

class BasicCreatePasswordPresenter implements CreatePasswordPresenter {
  late CreatePasswordModel model;
  late CreatePasswordView view;
  BasicCreatePasswordPresenter() {
    view = CreatePasswordView();
    model = CreatePasswordModel(isButtonTap: false);
  }

  @override
  Future<void> createPassword(
      {required String password,
      required String confirmPassword,
      required String mobile,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.forgetPassword,
        data: {
          'mobile': mobile,
          "password": password,
          "confirmPassword": confirmPassword
        },
        context: context);
    model.isButtonTap = false;
    if (response != null && response['status'] == 200) {
      context.router.pushAndPopUntil(const LoginScreenRoute(),
          predicate: (route) => false);
    }
    view.refreshModel(model);
  }

  @override
  set createPasswordView(CreatePasswordView value) {
    view = value;
    view.refreshModel(model);
  }
}
