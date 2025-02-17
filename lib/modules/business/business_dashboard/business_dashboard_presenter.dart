import 'package:flutter/material.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/model/company/company_portfolio_model.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

abstract class BusinessDashboardPresenter {
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {}
  Future<void> getCompanyDetails({
    required String userId,
    String? planID,
  }) async {}
  Future<void> getDashBoardData({required int catId}) async {}
  set updateView(BusinessDashboardView addMoneyView) {}
}

class BasicBusinessDashboardPresenter implements BusinessDashboardPresenter {
  late BusinessDashboardView view;
  late BusinessDashboardModel model;
  BasicBusinessDashboardPresenter(List<DashboardIncomeList> list) {
    model = BusinessDashboardModel(
        companyPortfolio: CompanyPorfolioModel(),
        todayBussiness: [],
        companyIncomeList: [
          DashboardIncomeList(name: 'Prime', income: '0', catId: 0),
          DashboardIncomeList(name: 'Prime B', income: '0', catId: 0),
          DashboardIncomeList(name: 'Booster', income: '0', catId: 0),
          DashboardIncomeList(name: 'Hybrid', income: '0', catId: 0),
        ],
        companyRoyalityList: [
          DashboardIncomeList(name: 'Silver', income: '0', catId: 0),
          DashboardIncomeList(name: 'Mobile Fund', income: '0', catId: 0),
          DashboardIncomeList(name: 'Car Fund', income: '0', catId: 0),
          DashboardIncomeList(name: 'Gold', income: '0', catId: 0),
          DashboardIncomeList(name: 'House Fund', income: '0', catId: 0),
          DashboardIncomeList(name: 'Platinum', income: '0', catId: 0),
          DashboardIncomeList(name: 'Travel Fund', income: '0', catId: 0),
          DashboardIncomeList(name: 'Diamond', income: '0', catId: 0),
          DashboardIncomeList(name: 'Comunity Fund', income: '0', catId: 0),
          DashboardIncomeList(name: 'Double Diamond', income: '0', catId: 0),
          DashboardIncomeList(name: 'Ambassador', income: '0', catId: 0),
        ],
        incomeList: list,
        filteredincomeList: []);
    view = BusinessDashboardView();
  }

  @override
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.teamDetails,
        data: {'user_id': userId, 'plan_id': planID},
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
      model.incomeList[10].income =
          model.teamDetails!.data!.first.silver.toString();
      model.incomeList[11].income =
          model.teamDetails!.data!.first.mobileFund.toString();
      model.incomeList[12].income =
          model.teamDetails!.data!.first.carFund.toString();
      model.incomeList[13].income =
          model.teamDetails!.data!.first.gold.toString();
      model.incomeList[14].income =
          model.teamDetails!.data!.first.houseFund.toString();
      model.incomeList[15].income =
          model.teamDetails!.data!.first.platinum.toString();
      model.incomeList[16].income =
          model.teamDetails!.data!.first.travelFund.toString();
      model.incomeList[17].income =
          model.teamDetails!.data!.first.diamond.toString();
      model.incomeList[18].income =
          model.teamDetails!.data!.first.comunityFund.toString();
      model.incomeList[19].income =
          model.teamDetails!.data!.first.doubleDiamond.toString();
      model.incomeList[20].income =
          model.teamDetails!.data!.first.ambassador.toString();

      // model.incomeList[16].income =
      //     model.teamDetails!.data!.first.houseFund.toString();
      // model.incomeList[16].income =
      //     model.teamDetails!.data!.first.houseFund.toString();
      getDashBoardData(catId: 0);
    }
  }

  @override
  Future<void> getCompanyDetails({
    required String userId,
    String? planID,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.companyPortfolio,
    );

    if (response != null && response['status'] == 200) {
      model.todayBussiness =
          CompanyPorfolioModel.fromJson(response).todayBussiness;

      model.companyPortfolio = CompanyPorfolioModel.fromJson(response);
      model.companyIncomeList[0].income =
          model.todayBussiness![0].primeA.toString();
      model.companyIncomeList[1].income =
          model.todayBussiness![0].primeB.toString();
      model.companyIncomeList[2].income =
          model.todayBussiness![0].booster.toString();
      model.companyIncomeList[3].income =
          model.todayBussiness![0].hybrid.toString();

      model.companyRoyalityList[0].income =
          model.companyPortfolio!.silver.toString();
      model.companyRoyalityList[1].income =
          model.companyPortfolio!.mobilefund.toString();
      model.companyRoyalityList[2].income =
          model.companyPortfolio!.carFund.toString();
      model.companyRoyalityList[3].income =
          model.companyPortfolio!.gold.toString();
      model.companyRoyalityList[4].income =
          model.companyPortfolio!.houseFund.toString();
      model.companyRoyalityList[5].income =
          model.companyPortfolio!.platinum.toString();
      model.companyRoyalityList[6].income =
          model.companyPortfolio!.travelFund.toString();
      model.companyRoyalityList[7].income =
          model.companyPortfolio!.diamond.toString();
      model.companyRoyalityList[8].income =
          model.companyPortfolio!.comunityFund.toString();
      model.companyRoyalityList[9].income =
          model.companyPortfolio!.doubleDiamond.toString();
      model.companyRoyalityList[10].income =
          model.companyPortfolio!.ambassador.toString();
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getDashBoardData({required int catId}) async {
    if (catId == 0) {
      model.filteredincomeList = model.incomeList;
    } else {
      model.filteredincomeList = [];

      for (int i = 0; i < model.incomeList.length; i++) {
        if (model.incomeList[i].catId == catId) {
          model.filteredincomeList.add(model.incomeList[i]);
        }
      }
    }
    view.refreshModel(model);
  }

  @override
  set updateView(BusinessDashboardView addMoneyView) {
    view = addMoneyView;
    view.refreshModel(model);
  }
}
