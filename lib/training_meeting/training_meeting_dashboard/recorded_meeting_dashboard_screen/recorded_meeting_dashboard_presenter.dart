import 'package:flutter/material.dart';
import 'package:defenders/model/training_meeting/get_recorded_categories_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class RecordedMeetingDashboardPresenter {
  Future<void> getRecordedTraining({required BuildContext context}) async {}
  set updateView(RecordedMeetingDashboardView addMoneyView) {}
}

class BasicRecordedMeetingDashboardPresenter
    implements RecordedMeetingDashboardPresenter {
  late RecordedMeetingDashboardView view;
  late RecordedMeetingDashboardModel model;
  BasicRecordedMeetingDashboardPresenter() {
    model = RecordedMeetingDashboardModel(categoriesList: []);
    view = RecordedMeetingDashboardView();
  }

  @override
  Future<void> getRecordedTraining({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getRecordedCategories,
        context: context,
        data: {'parent': '1'});
    if (response != null && response['status'] == 200) {
      model.categoriesList = GetTrainingVideoModel.fromJson(response).data!;

      view.refreshModel(model);
    }
  }

  @override
  set updateView(RecordedMeetingDashboardView trainingScreenView) {
    view = trainingScreenView;
    view.refreshModel(model);
  }
}
