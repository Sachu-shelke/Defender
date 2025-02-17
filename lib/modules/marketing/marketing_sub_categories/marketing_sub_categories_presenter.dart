import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/graphics/get_graphics_main_model.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_model.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class MarketingSubCategoriesPresenter {
  Future<void> getGraphics(
      {required int page,
      BuildContext? context,
      required String catId}) async {}

  Future<void> updateLike({
    required String id,
    required String action,
  }) async {}
  set updateView(MarketingSubCategoriesView incomePassbookView) {}
}

class BasicMarketingSubCategoriesPresenter
    implements MarketingSubCategoriesPresenter {
  late MarketingSubCategoriesView view;
  late MarketingSubCategoriesModel model;
  BasicMarketingSubCategoriesPresenter() {
    view = MarketingSubCategoriesView();
    model = MarketingSubCategoriesModel(graphicsdata: []);
  }

  @override
  Future<void> getGraphics(
      {required int page, BuildContext? context, required String catId}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getGraphics,
        data: {
          'page': page,
          'category_id': catId,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        },
        context: context);
    // print(response.toString());
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        model.graphicsdata =
            GetGraphicsMainModel.fromJson(response).data!.data!;
      } else {
        model.graphicsdata
            .addAll(GetGraphicsMainModel.fromJson(response).data!.data!);
      }
    }
    view.refreshModel(model);
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
  set updateView(MarketingSubCategoriesView redeemView) {
    view = redeemView;
    view.refreshModel(model);
  }
}
