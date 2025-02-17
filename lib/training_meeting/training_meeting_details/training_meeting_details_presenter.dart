import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_model.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TrainingMeetingDetailsPresenter {
  Future<void> updateTraining(
      {required BuildContext context,
      required String meetingId,
      required String isInvite,
      required String isEnroll,
      required String isJoin}) async {}
  set updateView(TrainingMeetingDetailsView addMoneyView) {}
}

class BasicTrainingMeetingDetailsPresenter
    implements TrainingMeetingDetailsPresenter {
  late TrainingMeetingDetailsView view;
  late TrainingMeetingDetailsModel model;
  BasicTrainingMeetingDetailsPresenter() {
    model = TrainingMeetingDetailsModel();
    view = TrainingMeetingDetailsView();
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
        // context: context,
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
  set updateView(TrainingMeetingDetailsView trainingScreenView) {
    view = trainingScreenView;
    view.refreshModel(model);
  }
}
