import 'package:flutter/material.dart';
import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_passbook_model.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_passbook_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class CashbackPassbookPresenter {
  Future<void> getPassbook({
    required String userID,
    BuildContext? context,
    required int page,
  }) async {}
  set updateView(CashbackPassbokkView mainHomeView) {}
}

class BasicCashbackPassbookPresenter implements CashbackPassbookPresenter {
  late CashbackPassbokkView view;
  late CashbackPassbookModel model;
  BasicCashbackPassbookPresenter() {
    view = CashbackPassbokkView();
    model = CashbackPassbookModel(lastPageIndex: 1, walletData: []);
  }

  @override
  Future<void> getPassbook({
    required String userID,
    BuildContext? context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.cashbackPassbook,
      context: context,
      data: {'user_id': userID, 'page': page},
    );

    if (response != null && response['status'] == 200) {
      WalletPassbookDataModel walletModel =
          WalletPassbookDataModel.fromJson(response);
      if (page == 1) {
        model.walletData = WalletPassbookDataModel.fromJson(response).data!;
      } else {
        model.walletData!
            .addAll(WalletPassbookDataModel.fromJson(response).data!);
      }

      // model.walletData.addAll(walletModel.data!);
      model.lastPageIndex = walletModel.totalPageCount ?? 1;
      view.refreshModel(model);
    } else {}
  }

  @override
  set updateView(CashbackPassbokkView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
