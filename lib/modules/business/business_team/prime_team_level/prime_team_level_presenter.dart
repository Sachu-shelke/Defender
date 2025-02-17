import 'package:flutter/material.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_model.dart';
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class PrimeTeamLevelPresenter {
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    required int page,
    required BuildContext context,
  }) async {}
  set updateView(PrimeTeamLevelView primeTeamLevelView) {}
}

class BasicPrimeTeamLevelPresenter implements PrimeTeamLevelPresenter {
  late PrimeTeamLevelModel model;
  late PrimeTeamLevelView view;

  BasicPrimeTeamLevelPresenter() {
    view = PrimeTeamLevelView();
    model = PrimeTeamLevelModel(teamDetailsdata: []);
  }

  @override
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    required BuildContext context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getTeamDeatils,
      context: context,
      data: {
        'user_id': userID,
        'teamType': primeId,
        'level': level,
        'plan_id': primeId,
        'page': page
      },
    );
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        model.teamDetailsdata = TeamDetailsInfoModel.fromJson(response).data!;
      } else {
        model.teamDetailsdata
            .addAll(TeamDetailsInfoModel.fromJson(response).data!);
      }

      view.refreshModel(model);
    }
  }

  @override
  set updateView(PrimeTeamLevelView primeTeamView) {
    view = primeTeamView;
    view.refreshModel(model);
  }
}
