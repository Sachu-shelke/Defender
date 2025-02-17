// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/main.dart';
import 'package:defenders/modules/auth/mpin/mpin_screen_model.dart';
import 'package:defenders/modules/auth/mpin/mpin_screen_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/snackbar/snackbars.dart';

class MpinScreenPresenter {
  Future<void> getMpinApi({
    required String mpin,
    required String userid,
    String? action,
    required BuildContext crn,
    required bool isFromSignup,
  }) async {}
  set mpinView(MpinView view) {}
}

class BasicMpinScreenPresenter implements MpinScreenPresenter {
  late MpinScreenModel model;
  late MpinView view;
  BasicMpinScreenPresenter() {
    view = MpinView();
    model = MpinScreenModel(
        didReadNotifications: false,
        pinCodeTry: 0,
        str: '',
        unReadNotificationsCount: 0);
  }

  @override
  Future<void> getMpinApi(
      {required String mpin,
      required String userid,
      String? action,
      required bool isFromSignup,
      required BuildContext crn}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getMpin,
        data: {
          'user_id': userid,
          'action': action != null ? 'Update' : '',
          'mpin': mpin,
          "app_id": "2"
        },
        context: crn);

    if (response != null && response['status'] == 200) {
      CommonMethod().getUserLog(action: 'Business_login', id: 7);
      appRouter.push(MainHomeScreenRoute());
    } else if (response != null && response['status'] == 401) {
      ScaffoldMessenger.of(crn)
          .showSnackBar(SnackBars.errorSnackBar(title: response['message']));
      StorageManager.clearSharedPreferences();
      appRouter.pushAndPopUntil(
        const LoginScreenRoute(),
        predicate: (route) => false,
      );
    } else {
      model.pinCodeTry = model.pinCodeTry + 1;
      model.controller!.forward(from: 0.0);

      ScaffoldMessenger.of(crn)
          .showSnackBar(SnackBars.errorSnackBar(title: response!['message']));
      Future.delayed(const Duration(milliseconds: 300), () {
        clearOtp();
      });
    }

    view.refreshModel(model);
  }

  void clearOtp() {
    model.fourthDigit = null;
    model.thirdDigit = null;
    model.secondDigit = null;
    model.firstDigit = null;
  }

  @override
  set mpinView(MpinView value) {
    view = value;
    view.refreshModel(model);
  }
}
