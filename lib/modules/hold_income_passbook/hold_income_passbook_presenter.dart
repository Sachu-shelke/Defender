import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/income_passbook/user_income_passbook_model.dart';
import 'package:defenders/modules/hold_income_passbook/hold_income_passbook_model.dart';
import 'package:defenders/modules/hold_income_passbook/hold_income_passbook_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class HoldIncomePassbookPresenter {
  Future<void> getIncomePassbook(
      {required int page,
      String? startDate,
      List? filter,
      String? endDate,
      required bool isForHoldIncome,
      BuildContext? context}) async {}
  set updateView(HoldIncomePassbookView incomePassbookView) {}
}

class BasicHoldIncomePassbookPresenter implements HoldIncomePassbookPresenter {
  late HoldIncomePassbookView view;
  late HoldIncomePassbookModel model;
  BasicHoldIncomePassbookPresenter() {
    view = HoldIncomePassbookView();
    model = HoldIncomePassbookModel(incomeList: []);
  }

  @override
  Future<void> getIncomePassbook(
      {required int page,
      String? startDate,
      String? endDate,
      List? filter,
      required bool isForHoldIncome,
      BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.holdPassbook,
        data: {
          'page': page,
          'startdate': startDate,
          'enddate': endDate,
          'filter': filter,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        },
        context: context);
    // log(response.toString());
    if (response != null &&
        response['status'] == 200 &&
        response['message'] != 'Data Not Found') {
      // model.incomeList = UserIncomePassbookModel.fromJson(response).data;
      // model.totalAmount = income.totalAmount;
      if (page == 1) {
        model.incomeList = UserIncomePassbookModel.fromJson(response).data;
      } else {
        // if (income.data != null) {
        model.incomeList!
            .addAll(UserIncomePassbookModel.fromJson(response).data ?? []);
        // } else {}
      }

      view.refreshModel(model);
    } else if (response != null && response['message'] == 'Data Not Found') {
      model.incomeList = [];
      // model.totalAmount = null;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(HoldIncomePassbookView incomePassbookView) {
    view = incomePassbookView;
    view.refreshModel(model);
  }
}
