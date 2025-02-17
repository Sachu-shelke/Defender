import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/training_meeting/get_recorded_video_list_mode.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class TrainingLeadsPresenter {
  Future<void> getRecordedTraining(
      {required BuildContext context, required String id}) async {}
  set updateView(TrainingLeadsView addMoneyView) {}
}

class BasicTrainingLeadsPresenter implements TrainingLeadsPresenter {
  late TrainingLeadsView view;
  late TrainingLeadsModel model;
  BasicTrainingLeadsPresenter() {
    model = TrainingLeadsModel(videoList: []);
    view = TrainingLeadsView();
  }

  @override
  Future<void> getRecordedTraining(
      {required BuildContext context, required String id}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getRecordedVideoList,
        context: context,
        data: {
          'category_id': id,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        });
    if (response != null && response['status'] == 200) {
      model.videoList = RecordedVideoModel.fromJson(response).data!;
      // model.data = GetTrainingModel.fromJson(response).data!;
      view.refreshModel(model);
    }
  }

  @override
  set updateView(TrainingLeadsView trainingScreenView) {
    view = trainingScreenView;
    view.refreshModel(model);
  }
}
