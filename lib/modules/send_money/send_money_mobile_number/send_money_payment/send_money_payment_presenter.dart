import 'package:flutter/material.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_model.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_view.dart';
import 'package:defenders/modules/suceess/send_money_sucess_screen.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class SendMoneyPaymentPresenter {
  Future<void> sendMoney({
    required BuildContext context,
    required String userId,
    required String amount,
    required String message,
    required String mobileNumber,
  }) async {}
  set updateView(SendMoneyPaymentView sendMoneyPaymentView) {}
}

class BasicSendMoneyPaymentPresenter implements SendMoneyPaymentPresenter {
  late SendMoneyPaymentView view;
  late SendMoneyPaymentModel model;
  BasicSendMoneyPaymentPresenter() {
    view = SendMoneyPaymentView();
    model = SendMoneyPaymentModel();
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
        data: {"to_user": userId, "amount": amount, "message": message},
        context: context);
    if (response != null && response['status'] == 200) {
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => SendMoneySuccessScreen(
            mobileNumber: mobileNumber,
            cashback: response['data']['amount'].toString(),
          ),
        ),
      );

      view.refreshModel(model);
    } else {}
  }

  @override
  set updateView(SendMoneyPaymentView sendMoneyPaymentView) {
    view = sendMoneyPaymentView;
    view.refreshModel(model);
  }
}
