import 'package:flutter/material.dart';
import 'package:defenders/model/home_model/rank_details_count_model.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_model.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TeamRankListPresenter {
  Future<void> getRankTeam(
      {required int page,
      required BuildContext context,
      required String rankName}) async {}
  set updateView(TeamRankListView addMoneyView) {}
}

class BasicTeamRankListPresenter implements TeamRankListPresenter {
  late TeamRankListView view;
  late TeamRankListModel model;
  BasicTeamRankListPresenter() {
    model = TeamRankListModel(data: []);
    view = TeamRankListView();
  }

  @override
  Future<void> getRankTeam(
      {required BuildContext context,
      required int page,
      required String rankName}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.totalRankDistribution,
        context: context,
        data: {'page': page, 'rank': rankName});
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        model.data = RankTeamListModel.fromJson(response).data!;
      } else {
        if (model.data.isNotEmpty) {
          model.data.addAll(RankTeamListModel.fromJson(response).data!);
        } else {}
      }
    }
    view.refreshModel(model);
  }

  @override
  set updateView(TeamRankListView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}
