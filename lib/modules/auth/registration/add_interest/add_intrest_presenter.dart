import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/auth_model/intrest_categories_model.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_model.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class AddIntrestPresenter {
  Future<void> getCategories({BuildContext? context}) async {}
  Future<void> addCategories({
    BuildContext? context,
    // required RegistrationPresenter signUpPresenter,
    // required SignupModel signupModel,
    required List idList,
  }) async {}
  set registrationView(AddIntrestView value) {}
}

class BasicAddIntrestPresenter implements AddIntrestPresenter {
  late AddIntrestModel model;
  late AddIntrestView view;
  BasicAddIntrestPresenter() {
    view = AddIntrestView();
    model = AddIntrestModel(
        interestsubSelectedCategoriesList: [], interestCategoriesList: []);
  }

  @override
  Future<void> getCategories({BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getIntrestCategory,
        context: context);
    if (response != null && response['status'] == 200) {
      GetInterestCategoriesModel getCategories =
          GetInterestCategoriesModel.fromJson(response);
      model.interestCategoriesList = getCategories.response!;
      view.refreshModel(model);
    }
  }

  @override
  Future<void> addCategories({
    BuildContext? context,
    // required RegistrationPresenter signUpPresenter,
    required List idList,
    // required SignupModel signupModel,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.addIntrestCategory,
        data: {
          'mobile': GlobalSingleton.loginInfo!.data!.mobile.toString(),
          'intrest_categories': idList.toString()
        },
        context: context);
    if (response != null && response['status'] == 200) {
      Navigator.pop(context!);
      // context!.router.push(
      //   OtpScreenRoute(
      //       otpType: 'REGISTER',
      //       presenter: signUpPresenter,
      //       signupModel: signupModel,
      //       mobileNumber: signupModel.mobile.toString()),
      // );
      //
      // view.refreshModel(model);
    }
  }

  @override
  set registrationView(
    AddIntrestView value,
  ) {
    view = value;
    view.refreshModel(model);
  }
}
