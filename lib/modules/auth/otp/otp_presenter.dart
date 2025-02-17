// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/encryption/encryption.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_storage_key.dart';
import 'package:defenders/model/auth_model/signup_model.dart';
import 'package:defenders/model/send_money/send_money_model.dart';
import 'package:defenders/modules/auth/otp/otp_mode.dart';
import 'package:defenders/modules/auth/otp/otp_view.dart';
import 'package:defenders/modules/auth/registration/registration_presenter.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_presenter.dart';
import 'package:defenders/modules/suceess/send_money_sucess_screen.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/snackbar/snackbars.dart';

class OtpPresenter {
  Future<void> getOtp(
      {required String mobileNumber,
      required String categories,
      required BuildContext context}) async {}
  Future<void> sendMoney({
    required BuildContext context,
    required String userId,
    required String amount,
    required String message,
    required String mobileNumber,
  }) async {}

  Future<void> unblockUser({
    BuildContext? context,
    required String userId,
  }) async {}
  Future<void> verifyOtp(
      {required String mobileNumber,
      required String categories,
      required String otp,
      final SignupModel? signupModel,
      final RegistrationPresenter? signUpPresenter,
      final SendMoneyPresenter? sendMoneypresenter,
      final String? sendMoneyAmount,
      final String? sendMoneyMobileNumber,
      final String? sendMoneyUserId,
      final String? sendMoneyMessage,
      final String? sendMoneyWalletType,
      required BuildContext context}) async {}
  set otpView(OtpView value) {}
}

class BasicOtpPresenter implements OtpPresenter {
  late OtpModel model;
  late OtpView view;
  BasicOtpPresenter() {
    view = OtpView();
    model = OtpModel(isButtonTap: false);
  }

  @override
  Future<void> getOtp(
      {required String mobileNumber,
      required String categories,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.otp,
        data: {
          "type": "Mobile",
          "mode": 'API',
          "mobile": mobileNumber,
          "email": "",
          "name": "",
          "category": categories
        },
        context: context);
    if (response != null && response['status'] == 200) {
      // CommonMethod().dialogData(
      //     context: context,
      //     title: 'Error',
      //     errorMessage: AppConstString.otpSendTitle);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.successSnackBar(title: AppConstString.otpSendTitle));
    }
  }

  @override
  Future<void> verifyOtp(
      {required String mobileNumber,
      required String categories,
      required String otp,
      final SignupModel? signupModel,
      final RegistrationPresenter? signUpPresenter,
      final SendMoneyPresenter? sendMoneypresenter,
      final String? sendMoneyAmount,
      final String? sendMoneyMobileNumber,
      final String? sendMoneyUserId,
      final String? sendMoneyMessage,
      final String? sendMoneyWalletType,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.verifyOtp,
        data: {
          "type": "Mobile",
          "mode": 'API',
          "mobile": mobileNumber,
          "category": categories,
          "otp": otp,
        },
        context: context);
    model.isButtonTap = false;
    if (response != null && response['status'] == 200) {
      if (categories == 'Forgot Password') {
        // context.router.pushAndPopUntil(route, predicate: predicate)
        context.router.pushAndPopUntil(
            CreatePasswordScreenRoute(mobilerNumber: mobileNumber),
            predicate: (route) => false);
      } else if (categories == 'Active Id') {
        unblockUser(
          userId: mobileNumber,
          context: context,
        );
      } else if (categories == 'Send Money') {
        sendMoney(
            context: context,
            sendMoneyWalletType: sendMoneyWalletType,
            amount: sendMoneyAmount.toString(),
            message: sendMoneyMessage.toString(),
            mobileNumber: sendMoneyMobileNumber.toString(),
            userId: sendMoneyUserId.toString());
      } else if (categories == 'Forget MPIN') {
        // isForgetOtp
        context.router.pushAndPopUntil(
            PinCodeOtpRoute(
                isSignup: false, isForgetOtp: true, isSplash: false),
            predicate: (route) => false);
      } else if (categories == 'REGISTER') {
        signUpPresenter!.register(model: signupModel!, context: context);
      } else {
        StorageManager.setStringValue(
          key: 'data',
          value: encrypt(
            text: jsonEncode(GlobalSingleton.loginInfo),
          ),
        );
        await NetworkDio.setDynamicHeader(
          authorizationToken:
              GlobalSingleton.loginInfo!.refreshToken.toString(),
        );
        StorageManager.setBoolValue(key: AppStorageKey.isLogIn, value: true);
        context.router.pushAndPopUntil(
            PinCodeOtpRoute(
                isSignup: categories == "REGISTER" ? true : false,
                isSplash: false),
            predicate: (route) => false);
      }
    }
    view.refreshModel(model);
  }

  @override
  Future<void> unblockUser({
    BuildContext? context,
    required String userId,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.unblockUser,
        data: {
          "mobile_no": userId,
        },
        context: context);
    if (response != null && response['status'] == 200) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBars.successSnackBar(
          title: 'Your ID is unblocked, Enjoy Mirror Services'));
      context.router.pushAndPopUntil(
        const LoginScreenRoute(),
        predicate: (route) => false,
      );
      // SendMoneyModel sendMoney = SendMoneyModel.fromJson(response);
      // Navigator.push(
      //   context!,
      //   MaterialPageRoute(
      //     builder: (context) => SendMoneySuccessScreen(
      //       mobileNumber: mobileNumber,
      //       cashback: sendMoney.data!.amount.toString(),
      //       title: sendMoney.message.toString(),
      //       transaction: sendMoney.data!.fromTransactionId.toString(),
      //     ),
      //   ),
      // );

      view.refreshModel(model);
    } else {}
  }

  @override
  Future<void> sendMoney({
    BuildContext? context,
    required String userId,
    required String amount,
    required String message,
    required String mobileNumber,
    String? sendMoneyWalletType,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.sendMoney,
        data: {
          "to_user": userId,
          "user_id": GlobalSingleton.loginInfo!.data!.id.toString(),
          "amount": amount,
          "message": message,
          "wallet": sendMoneyWalletType != null
              ? sendMoneyWalletType.toString()
              : "Main"
        },
        context: context);
    if (response != null && response['status'] == 200) {
      SendMoneyModel sendMoney = SendMoneyModel.fromJson(response);
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => SendMoneySuccessScreen(
            mobileNumber: mobileNumber,
            cashback: sendMoney.data!.amount.toString(),
            title: sendMoney.message.toString(),
            transaction: sendMoney.data!.fromTransactionId.toString(),
          ),
        ),
      );

      view.refreshModel(model);
    } else {}
  }

  @override
  set otpView(OtpView value) {
    view = value;
    view.refreshModel(model);
  }
}
