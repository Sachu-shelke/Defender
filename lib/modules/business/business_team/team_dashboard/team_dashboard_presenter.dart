import 'package:flutter/material.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_model.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TeamDashboardPresenter {
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {}
  set updateView(TeamDashboardView primeTeamLevelView) {}
}

class BasicTeamDashboardPresenter implements TeamDashboardPresenter {
  late TeamDashboardModel model;
  late TeamDashboardView view;
  BasicTeamDashboardPresenter(List<DashboardIncomeList> list) {
    model = TeamDashboardModel(incomeList: list);
    view = TeamDashboardView();
  }

  @override
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.teamDetails,
        data: {
          'user_id': userId,
          'plan_id': planID
        }, //{'encReq': base64Encode(utf8.encode(enc))},
        context: context);

    if (response != null && response['status'] == 200) {
      model.teamDetails = TeamDetailsModel.fromJson(response);
      model.incomeList.first.income = AppConstString.rupeesSymbol +
          model.teamDetails!.data!.first.totalEarning.toString();
      model.incomeList[1].income = AppConstString.rupeesSymbol +
          model.teamDetails!.data!.first.totalWithdrawal.toString();
      model.incomeList[2].income =
          model.teamDetails!.data!.first.totalMember.toString();
      model.incomeList[3].income =
          model.teamDetails!.data!.first.primeB.toString();
      model.incomeList[4].income =
          model.teamDetails!.data!.first.booster.toString();
      model.incomeList[5].income =
          model.teamDetails!.data!.first.hybrid.toString();
      model.incomeList[7].income =
          model.teamDetails!.data!.first.totalRepurchaseIncome.toString();
      // getDashBoardData(catId: 0);
    }
    view.refreshModel(model);
  }

  @override
  set updateView(TeamDashboardView primeTeamView) {
    view = primeTeamView;
    view.refreshModel(model);
  }
}
