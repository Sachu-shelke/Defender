import 'package:flutter/material.dart';
import 'package:defenders/model/prime_plan_model/get_prime_plan_details_model.dart';
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_model.dart';
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class PrimeDashboardPresenter {
  Future<void> getPrimePlanDetails({
    required BuildContext context,
  }) async {}
  set updateView(PrimeDashboardView primeDashboardView) {}
}

class BasicPrimeDashboardPresenter implements PrimeDashboardPresenter {
  late PrimeDashboardView view;
  late PrimeDashboardModel model;
  BasicPrimeDashboardPresenter() {
    view = PrimeDashboardView();
    model = PrimeDashboardModel(primeList: []);
  }

  @override
  Future<void> getPrimePlanDetails({
    BuildContext? context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getAllPrimePlanDetails,
        context: context);
    if (response != null && response['status'] == 200) {
      model.primeList = GetPrimePlanDetailsModel.fromJson(response).data!;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(PrimeDashboardView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
