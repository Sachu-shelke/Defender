import 'package:flutter/material.dart';
import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';
import 'package:defenders/modules/passbook/prime_passbook/prime_passbook_model.dart';
import 'package:defenders/modules/passbook/prime_passbook/prime_passbook_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class PrimePassbookPresenter {
  Future<void> getPassbook({
    required String userID,
    BuildContext? context,
    required int page,
  }) async {}
  set updateView(PrimePassbokkView mainHomeView) {}
}

class BasicPrimePassbookPresenter implements PrimePassbookPresenter {
  late PrimePassbokkView view;
  late PrimePassbookModel model;
  BasicPrimePassbookPresenter() {
    view = PrimePassbokkView();
    model = PrimePassbookModel(walletData: []);
  }

  @override
  Future<void> getPassbook({
    required String userID,
    BuildContext? context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.primePassbook,
      context: context,
      data: {'user_id': userID, 'page': page},
    );

    if (response != null && response['status'] == 200) {
      if (page == 1) {
        model.walletData = WalletPassbookDataModel.fromJson(response).data!;
      } else {
        model.walletData!
            .addAll(WalletPassbookDataModel.fromJson(response).data!);
      }

      view.refreshModel(model);
    } else {}
  }

  @override
  set updateView(PrimePassbokkView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
