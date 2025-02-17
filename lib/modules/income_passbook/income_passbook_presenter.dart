import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/income_passbook/user_income_passbook_model.dart';
import 'package:defenders/modules/income_passbook/income_passbook_model.dart';
import 'package:defenders/modules/income_passbook/income_passbook_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class IncomePassbookPresenter {
  Future<void> getIncomePassbook(
      {required int page,
      String? startDate,
      List? filter,
      String? endDate,
      BuildContext? context}) async {}
  set updateView(IncomePassbookView incomePassbookView) {}
}

class BasicIncomePassbookPresenter implements IncomePassbookPresenter {
  late IncomePassbookView view;
  late IncomePassbookModel model;
  BasicIncomePassbookPresenter() {
    view = IncomePassbookView();
    model = IncomePassbookModel(incomeList: []);
  }

  @override
  Future<void> getIncomePassbook(
      {required int page,
      String? startDate,
      String? endDate,
      List? filter,
      BuildContext? context}) async {
    print(filter);
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.incomePassbook,
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
      UserIncomePassbookModel income =
          UserIncomePassbookModel.fromJson(response);
      model.totalAmount = income.totalAmount;
      if (page == 1) {
        model.incomeList = income.data;
      } else {
        if (income.data != null) {
          model.incomeList!.addAll(income.data!);
        } else {}
      }

      view.refreshModel(model);
    } else if (response != null && response['message'] == 'Data Not Found') {
      model.incomeList = [];
      model.totalAmount = null;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(IncomePassbookView incomePassbookView) {
    view = incomePassbookView;
    view.refreshModel(model);
  }
}
