// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/feedback_model/get_feedback_category_by_id.dart';
import 'package:defenders/model/feedback_model/get_feedback_category_model.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen_model.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class FeedbackPresenter {
  Future<void> getCategories({
    required String userID,
    required BuildContext context,
  }) async {}
  Future<void> addFeedback({
    required String userID,
    required BuildContext context,
  }) async {}
  Future<void> getReasonById({
    required String category,
    required BuildContext context,
  }) async {}
  set updateView(FeedbackView addMoneyView) {}
}

class BasicFeedbackPresenter implements FeedbackPresenter {
  late FeedbackView view;
  late FeebackScreenModel model;
  BasicFeedbackPresenter() {
    model = FeebackScreenModel(
      controller: TextEditingController(),
      feedbackCategoryData: [],
      feedbackCategoryDatabyId: [],
    );
    view = FeedbackView();
  }

  @override
  Future<void> getCategories({
    required String userID,
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getFeedBackCategories,
        data: {'cat_group': 'Chat Support'},
        context: context);

    if (response != null && response['status'] == 200) {
      // print(response.toString());
      model.feedbackCategoryData =
          GetFeedbackCategoryModel.fromJson(response).response!;
      view.refreshModel(model);
    }
  }

  @override
  Future<void> addFeedback({
    required String userID,
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.addFeedback,
        isEncryptionUse: true,
        data: FormData.fromMap({
          'userid': userID,
          'category_id': model.selectedCategoriesId,
          'reason_id': model.selectedReasonId,
          'mobile': GlobalSingleton.loginInfo!.data!.mobile.toString(),
          'problem_description': model.controller.text,
          'image': await MultipartFile.fromFile(
            model.selectedFile!,
            filename: 'cheque.jpg',
          ),
        }),
        context: context);

    if (response != null &&
        (response['status'] == 200 || response['status'] == 201)) {
      CommonMethod().getUserLog(action: 'Feedback_Ticket', id: 3);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBars.successSnackBar(title: 'Feedback added successfully'));
      CustomModalBottomSheet.show(context: context, serviceName: 'Feedback');
      // context.router.push(MainHomeScreenRoute(isFromSignup: false));
    }
  }

  @override
  Future<void> getReasonById({
    required String category,
    required BuildContext context,
  }) async {
    model.feedbackCategoryDatabyId.clear();
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getFeedbackReason,
      context: context,
      data: {
        'category_id': category,
      },
    );

    if (response != null &&
        response['status'] == 200 &&
        response['data'].runtimeType == List) {
      model.feedbackCategoryDatabyId =
          GetFeedbackCategoriesByIdModel.fromJson(response).response!;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(FeedbackView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}
