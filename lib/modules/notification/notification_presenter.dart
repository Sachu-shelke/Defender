import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/model/notification/notification_model.dart';
import 'package:defenders/modules/notification/notification_model.dart';
import 'package:defenders/modules/notification/notification_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';

class NotificationPresenter {
  Future<void> getNotification({
    required BuildContext context,
    required int page,
  }) async {}
  set updateView(NotificationView incomePassbookView) {}
}

class BasicNotificationPresenter implements NotificationPresenter {
  late NotificationView view;
  late NotificationScreenModel model;
  BasicNotificationPresenter() {
    view = NotificationView();
    model = NotificationScreenModel(notificationdata: []);
  }

  @override
  Future<void> getNotification({
    required BuildContext context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.notification,
      context: context,
      data: {
        'app_id': '2',
        'page': page,
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
      },
    );

    if (response != null && response['status'] == 200) {
      model.notificationdata = NotificationModel.fromJson(response).data!.data!;
    }
    view.refreshModel(model);
  }

  @override
  set updateView(NotificationView redeemView) {
    view = redeemView;
    view.refreshModel(model);
  }
}
