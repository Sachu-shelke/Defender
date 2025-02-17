import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/profile/profile_model.dart';
import 'package:defenders/modules/profile/profile_model.dart';
import 'package:defenders/modules/profile/profile_screen_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class ProfilePresenter {
  Future<void> getProfile({
    required BuildContext context,
  }) async {}
  set updateView(ProfileView primeDashboardView) {}
}

class BasicProfilePresenter implements ProfilePresenter {
  late ProfileView view;
  late ProfileModel model;

  BasicProfilePresenter() {
    view = ProfileView();
    model =
        ProfileModel(totalCashback: 0, totalReferral: 0, data: ProfileData());
  }

  @override
  Future<void> getProfile({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getProfile,
        data: {
          'id': GlobalSingleton.loginInfo!.data!.id.toString(),
        },
        context: context);

    if (response != null && response['status'] == 200) {
      ProfileScreenModel mod = ProfileScreenModel.fromJson(response);
      model.data = mod.data!.first;
      model.totalCashback = mod.totalCashback ?? 0;
      model.totalReferral = mod.totalReferral ?? 0;
    }
    view.refreshModel(model);
  }

  @override
  set updateView(ProfileView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
