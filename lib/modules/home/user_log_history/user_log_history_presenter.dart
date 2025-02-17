import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/home_model/royality_progress_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class UserLogHistoryPresenter {
  Future<void> userLogHistory({required BuildContext context}) async {}
  set updateView(UserLogHistoryView addMoneyView) {}
}

class BasicUserLogHistoryPresenter implements UserLogHistoryPresenter {
  late UserLogHistoryView view;
  late UserLogHistoryModel model;
  BasicUserLogHistoryPresenter() {
    model = UserLogHistoryModel(royalityModel: []);
    view = UserLogHistoryView();
  }

  @override
  Future<void> userLogHistory({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.userLogHistory,
      context: context,
      data: {
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
      },
    );

    if (response != null && response['status'] == 200) {
      RoyalityProgressModel mod = RoyalityProgressModel.fromJson(response);
      model.dataMap = {
        "Achieve Business":
            double.parse(mod.totalTaskdone!.first.percentage.toString()),
        "Remaining Business ": double.parse("100") -
            double.parse(mod.totalTaskdone!.first.percentage.toString()),
      };
      model.royalityModel = mod.data!;
    }
    view.refreshModel(model);
  }

  @override
  set updateView(UserLogHistoryView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}
