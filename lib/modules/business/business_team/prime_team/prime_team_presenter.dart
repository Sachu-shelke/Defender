import 'package:flutter/material.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/business/business_team/prime_team/prime_team_model.dart';
import 'package:defenders/modules/business/business_team/prime_team/prime_team_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class PrimeTeamPresenter {
  Future<void> getTeamDetails(
      {required String userId,
      required String planID,
      required BuildContext context}) async {}
  set updateView(PrimeTeamView primeTeamView) {}
}

class BasicPrimeTeamPresenter implements PrimeTeamPresenter {
  late PrimeTeamModel model;
  late PrimeTeamView view;

  BasicPrimeTeamPresenter() {
    view = PrimeTeamView();
    model = PrimeTeamModel(myTeamList: [
      {
        'level': "1",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "2",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "3",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "4",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "5",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "6",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
      {
        'level': "7",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "8",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "9",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "10",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "11",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "12",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "13",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "14",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
       {
        'level': "15",
        'totalUser': "100",
        'active': "50",
        'inActive': "50",
      },
    ]);
  }
  @override
  Future<void> getTeamDetails(
      {required String userId,
      required String planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.teamDetails,
        data: {'user_id': userId, 'plan_id': planID},
        context: context);

    if (response != null && response['status'] == 200) {
      model.teamDetails = TeamDetailsModel.fromJson(response);
      view.refreshModel(model);
    }
  }

  @override
  set updateView(PrimeTeamView primeTeamView) {
    view = primeTeamView;
    view.refreshModel(model);
  }
}
