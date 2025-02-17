import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/training_meeting/get_training_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TrainingMeetingDashboardPresenter {
  Future<void> getTrainingData(
      {required BuildContext context, required String date}) async {}
  Future<void> updateTraining(
      {required BuildContext context,
      required String meetingId,
      required String isInvite,
      required String isEnroll,
      required String isJoin}) async {}
  set updateView(TrainingMeetingDashboardView addMoneyView) {}
}

class BasicTrainingMeetingDashboardPresenter
    implements TrainingMeetingDashboardPresenter {
  late TrainingMeetingDashboardView view;
  late TrainingMeetingDashboardModel model;
  BasicTrainingMeetingDashboardPresenter() {
    model = TrainingMeetingDashboardModel(data: []);
    view = TrainingMeetingDashboardView();
  }

  @override
  Future<void> getTrainingData(
      {required BuildContext context, required String date}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getTraining,
        context: context,
        data: {
          // 'date': date,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        });
    if (response != null && response['status'] == 200) {
      model.data = GetTrainingModel.fromJson(response).data!;
      view.refreshModel(model);
    }
  }

  @override
  Future<void> updateTraining(
      {required BuildContext context,
      required String meetingId,
      required String isInvite,
      required String isEnroll,
      required String isJoin}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.updateStatusInMeeting,
        context: context,
        data: {
          'meeting_id': meetingId,
          'is_invite': isInvite,
          'is_enroll': isEnroll,
          'is_join': isJoin,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        });
    if (response != null && response['status'] == 200) {
      view.refreshModel(model);
    }
  }

  @override
  set updateView(TrainingMeetingDashboardView trainingScreenView) {
    view = trainingScreenView;
    view.refreshModel(model);
  }
}
