import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/main.dart';
import 'package:defenders/model/additional_info_model.dart';
import 'package:defenders/model/base_model/base_model.dart';
import 'package:defenders/model/prime_plan_model/get_prime_plan_details_model.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_screen.dart';
import 'package:defenders/modules/auth/registration/gender_selection/gender_selection_screen.dart';
import 'package:defenders/modules/main_home/main_home_model.dart';
import 'package:defenders/modules/main_home/mian_home_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class MainHomePresenter {
  Future<void> checkBackupData({required BuildContext context}) async {}
  Future<void> getPrimePlanDetails({
    required BuildContext context,
  }) async {}
  Future<void> getAdditionalUserInfoDetails({
    required BuildContext context,
  }) async {}
  set updateView(MainHomeView mainHomeView) {}
}

class BasicMainHomePresenter implements MainHomePresenter {
  late MainHomeView view;
  late MainHomeModel model;
  BasicMainHomePresenter() {
    view = MainHomeView();
    model = MainHomeModel(selectedIndex: 0, primeList: []);
  }

  @override
  Future<void> checkBackupData({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.checkDataBackup,
      data: {'user_id': GlobalSingleton.loginInfo!.data!.id.toString()},
      // context: context
    );

    if (response != null && response['status'] == 200) {
      BaseModel mod = BaseModel.fromJson(response);
      if (mod.data == true) {
      } else {
        appRouter
            .pushAndPopUntil(
              const DataUploadingScreenRoute(),
              predicate: (route) => false,
            )
            .then((value) {});
      }
    }
  }

  @override
  Future<void> getAdditionalUserInfoDetails({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getAddditionalInfoDetails,
      data: {
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
      },
      // context: context
    );
    if (response != null && response['status'] == 200) {
      UserAdditionalInfoModelData dataList =
          UserAdditionalInfoModel.fromJson(response).data!;

      if (dataList.isInterest == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InterestScareen(),
          ),
        );
      } else if (dataList.isGender == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupProfileScreen(),
          ),
        );
      }
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getPrimePlanDetails({
    BuildContext? context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getAllPrimePlanDetails,
      // context: context
    );
    if (response != null && response['status'] == 200) {
      model.primeList = GetPrimePlanDetailsModel.fromJson(response).data!;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(MainHomeView mainHomeView) {
    view = mainHomeView;
    view.refreshModel(model);
  }
}
