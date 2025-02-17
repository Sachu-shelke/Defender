import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_model.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class WalletPassbookPresenter {
  Future<void> getPassbook({
    required String userID,
    String? filter,
    required int page,
    BuildContext? context,
  }) async {}
  set updateView(WalletPassbokkView mainHomeView) {}
}

class BasicWalletPassbookPresenter implements WalletPassbookPresenter {
  late WalletPassbokkView view;
  late WalletPassbookModel model;
  BasicWalletPassbookPresenter() {
    view = WalletPassbokkView();
    model = WalletPassbookModel(walletData: [], lastPageIndex: 0);
  }

  @override
  Future<void> getPassbook({
    required String userID,
    String? filter,
    BuildContext? context,
    required int page,
  }) async {
    // model.walletData = [];
    log(page.toString());
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + ApiPath.passbook,
      context: context,
      data: {'user_id': userID, 'filter': filter, 'page': page},
    );

    if (response != null && response['status'] == 200) {
      if (page == 1) {
        WalletPassbookDataModel mod =
            WalletPassbookDataModel.fromJson(response);
        model.walletData = mod.data;
        model.lastPageIndex = mod.totalPageCount ?? 0;
      } else {
        model.walletData!
            .addAll(WalletPassbookDataModel.fromJson(response).data!);
      }
    } else {}
    view.refreshModel(model);
  }

  @override
  set updateView(WalletPassbokkView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
