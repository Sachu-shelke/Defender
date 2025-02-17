// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/model/graphics/new_graphics/new_get_graphics_categories_model.dart';
import 'package:defenders/model/graphics/new_graphics/new_get_graphics_modekl.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_model.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class MarketingDashboardScreenPresenter {
  Future<void> getCategoriesLeads({
    required BuildContext context,
    required bool isGridView,
  }) async {}
  Future<void> getGraphics({
    required String catID,
    required bool isGridView,
    required BuildContext context,
  }) async {}
  set updateView(MarketingDashboardView addMoneyView) {}
  Future<void> updateLike({
    required String id,
    required String action,
  }) async {}
}

class BasicMarketingDashboardScreenPresenter
    implements MarketingDashboardScreenPresenter {
  late MarketingDashboardView view;
  late MarketingDashboardModel model;
  BasicMarketingDashboardScreenPresenter() {
    model = MarketingDashboardModel(
        todaysStatus: [],
        isSelectedValue: NewGraphicsCategoryData(),
        marketingCategories: [],
        marketingSubCategories: []);
    view = MarketingDashboardView();
  }

  @override
  Future<void> getCategoriesLeads({
    required BuildContext context,
    required bool isGridView,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getGraphicsCategories,
        context: context);
    if (response != null && response['status'] == 200) {
      model.todaysStatus =
          NewGetGraphicsCategoryModel.fromJson(response).todaysStatus!;
      model.marketingCategories =
          NewGetGraphicsCategoryModel.fromJson(response).data!;
      model.isSelectedValue = model.marketingCategories.first;
      getGraphics(
          catID: model.marketingCategories.first.id.toString(),
          isGridView: isGridView,
          context: context);
      view.refreshModel(model);
    }
  }

  @override
  Future<void> getGraphics({
    required String catID,
    required BuildContext context,
    required bool isGridView,
  }) async {
    // if (StorageManager.getStringValue('MarketingData') != null) {
    //   String data = StorageManager.getStringValue('MarketingData')!;

    //   model.marketingSubCategories = NewGetGraphicsData.decode(data);
    // } else {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getNewGraphics,
      context: context,
      data: {
        'category_id': isGridView == false ? null : catID,
        'page': 1,
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
      },
    );
    if (response != null && response['status'] == 200) {
      model.marketingSubCategories =
          NewGetGraphicsModel.fromJson(response).data!;

      StorageManager.setStringValue(
        key: 'MarketingData',
        value: NewGetGraphicsData.encode(
          model.marketingSubCategories,
        ),
      );
    }
    view.refreshModel(model);
    // }
  }

  @override
  Future<void> updateLike({
    required String id,
    required String action,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.updateLike,
        data: {
          'id': id,
          'action': action,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        });
    if (response != null && response['status'] == 200) {
      view.refreshModel(model);
    }
  }

  @override
  set updateView(MarketingDashboardView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}

// class MarketingDashboardPresenter {
//   Future<void> getGraphics({required BuildContext context}) async {}
//   set updateView(MarketingDashboardView incomePassbookView) {}
// }

// class BasicMarketingDashboardPresenter implements MarketingDashboardPresenter {
//   late MarketingDashboardView view;
//   late MarketingDashboardModel model;
//   BasicMarketingDashboardPresenter() {
//     view = MarketingDashboardView();
//     model = MarketingDashboardModel(graphicsdata: GetGraphicsCategoryModel());
//   }

//   @override
//   Future<void> getGraphics({required BuildContext context}) async {
//     Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
//       url: ApiPath.apiEndPoint + ApiPath.getGraphicsCategories,
//       // data: {'user_id': GlobalSingleton.loginInfo!.data!.id.toString()},
//       // context: context
//     );

//     if (response != null && response['status'] == 200) {
//       model.graphicsdata = GetGraphicsCategoryModel.fromJson(response);
//     }
//     view.refreshModel(model);
//   }

//   @override
//   set updateView(MarketingDashboardView redeemView) {
//     view = redeemView;
//     view.refreshModel(model);
//   }
// }
