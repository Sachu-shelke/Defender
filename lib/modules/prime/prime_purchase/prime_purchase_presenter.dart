// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_model.dart';
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class PrimePurchasePresenter {
  Future<void> planPurchase({
    required BuildContext context,
    required String planId,
    required String planAmount,
    required bool isFromEpin,
    required String? userId,
    required int isSelectedWallet,
  }) async {}
  set updateView(PrimePurchaseView primeDashboardView) {}
}

class BasicPrimePurchasePresenter implements PrimePurchasePresenter {
  late PrimePurchaseView view;
  late PrimePurchaseModel model;
  BasicPrimePurchasePresenter() {
    view = PrimePurchaseView();
    model = PrimePurchaseModel();
  }

  @override
  Future<void> planPurchase({
    required BuildContext context,
    required String planId,
    required String planAmount,
    required bool isFromEpin,
    required String? userId,
    required int isSelectedWallet,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.primePurchase,
        data: {
          'user_id': (userId != null)
              ? userId
              : GlobalSingleton.loginInfo!.data!.id.toString(),
          'plan_id': planId,
          'amount': planAmount,
          "wallet": isSelectedWallet == 1 ? 'Epin' : "Main",
          if (userId != null)
            "sender_user_id": GlobalSingleton.loginInfo!.data!.id.toString()

          // userId,
        },
        context: context);
    if (response != null && response['status'] == 200) {
      context.router.push(const PrimeSucessScreenRoute());
      view.refreshModel(model);
    }
  }

  @override
  set updateView(PrimePurchaseView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
