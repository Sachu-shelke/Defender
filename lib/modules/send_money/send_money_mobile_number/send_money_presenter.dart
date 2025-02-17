import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/model/recharge_model/recent_recharge_model.dart';
import 'package:defenders/model/send_money/send_money_model.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_model.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_view.dart';
import 'package:defenders/modules/suceess/send_money_sucess_screen.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class SendMoneyPresenter {
  Future<void> sendMoneyUserDetails({
    required BuildContext context,
    required String mobileNumber,
  }) async {}
  Future<void> sendMoney({
    required BuildContext context,
    required String userId,
    required String amount,
    required String message,
    required String mobileNumber,
  }) async {}
  Future<void> recentSendMoney({
    BuildContext? context,
    required String? isFromEpin,
    required String userID,
  }) async {}
  set updateView(SendMoneyView sendMoneyView) {}
}

class BasicSendMoneyPresenter implements SendMoneyPresenter {
  late SendMoneyView view;
  late SendMoneyScreenModel model;
  BasicSendMoneyPresenter() {
    view = SendMoneyView();
    model =
        SendMoneyScreenModel(recentSendMoneyList: [], userDetails: LoginData());
  }

  @override
  Future<void> sendMoneyUserDetails({
    BuildContext? context,
    required String mobileNumber,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.sendMoneyUserDeatisl,
        data: {'mobile_no': mobileNumber},
        context: context);
    if (response != null && response['status'] == 200) {
      model.userDetails = LoginModel.fromJson(response).data!;

      view.refreshModel(model);
    } else {
      model.userDetails = LoginData();
    }
  }

  @override
  Future<void> sendMoney({
    BuildContext? context,
    required String userId,
    required String amount,
    required String message,
    required String mobileNumber,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.sendMoney,
        data: {
          "to_user": userId,
          "user_id": GlobalSingleton.loginInfo!.data!.id.toString(),
          "amount": amount,
          "message": message
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
  Future<void> recentSendMoney(
      {BuildContext? context,
      required String? isFromEpin,
      required String userID}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.recentSendMoney,
        data: {
          "user_id": userID,
          "wallet": isFromEpin == "true" ? "Main" : "Epin"
        },
        context: context);
    if (response != null && response['status'] == 200) {
      model.recentSendMoneyList = RecentRechargeModel.fromJson(response).data!;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(SendMoneyView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
