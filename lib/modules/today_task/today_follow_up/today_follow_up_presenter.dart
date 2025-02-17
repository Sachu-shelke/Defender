import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/msg_content/msg_content_model.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_model.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TodayFollowUpPresenter {
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    required int page,
    BuildContext? context,
  }) async {}
  Future<void> getMsgContent({
    required BuildContext context,
  }) async {}
  Future<void> getTotalCount({
    BuildContext? context,
  }) async {}
  set updateView(TodayFollowUpView sendMoneyView) {}
}

class BaasicTodayFollowUpPresenter implements TodayFollowUpPresenter {
  late TodayFollowUpView view;
  late TodayFollowUpModel model;
  BaasicTodayFollowUpPresenter() {
    view = TodayFollowUpView();
    model = TodayFollowUpModel(
        todayData: TeamDetailsInfoModel(),
        msg: GetMsgCotentData(),
        level: "1",
        teamDetailsdata: []);
  }

  @override
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    BuildContext? context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getRandomTeamDeatils,
      context: context,
      data: {
        'user_id': userID,
        'teamType': primeId,
        'level': level,
        'plan_id': primeId,
        'page': page,
      },
    );
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        TeamDetailsInfoModel mod = TeamDetailsInfoModel.fromJson(response);
        model.teamDetailsdata = mod.data!;
        model.level = mod.level.toString();
      } else {
        model.teamDetailsdata
            .addAll(TeamDetailsInfoModel.fromJson(response).data!);
      }

      view.refreshModel(model);
    }
  }

  @override
  Future<void> getTotalCount({
    BuildContext? context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.dailyTeamDetails,
      context: context,
      data: {
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
        "type": "Prime",
        'page': 1
      },
    );

    log(response.toString());
    if (response != null && response['status'] == 200) {
      model.todayData = TeamDetailsInfoModel.fromJson(response);
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getMsgContent({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.msgContectnt,
        // context: context,
        data: {});
    if (response != null && response['status'] == 200) {
      model.msg = GetMsgCotentModel.fromJson(response).data!;
    }
    view.refreshModel(model);
  }

  @override
  set updateView(TodayFollowUpView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
