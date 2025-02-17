import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/home_model/royality_progress_history_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_mode.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class UserLogDateWiseHistoryPresenter {
  Future<void> userLogHistory(
      {required BuildContext context, required String date}) async {}
  set updateView(UserLogDateWiseView addMoneyView) {}
}

class BasicUserLogDateWiseHistoryPresenter
    implements UserLogDateWiseHistoryPresenter {
  late UserLogDateWiseView view;
  late UserLogDateWiseHistoryModel model;
  BasicUserLogDateWiseHistoryPresenter() {
    model = UserLogDateWiseHistoryModel(royalityModel: []);
    view = UserLogDateWiseView();
  }

  @override
  Future<void> userLogHistory(
      {required BuildContext context, required String date}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.userLogDateHistory,
      context: context,
      data: {
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
        "log_date": date
      },
    );
    log(json.encode(response));
    if (response != null && response['status'] == 200) {
      UserLogDateHistoryModel mod = UserLogDateHistoryModel.fromJson(response);

      model.royalityModel = mod.data!;
    }
    view.refreshModel(model);
  }

  @override
  set updateView(UserLogDateWiseView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}
