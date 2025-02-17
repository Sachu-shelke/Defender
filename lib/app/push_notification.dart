// ignore_for_file: depend_on_referenced_packages, empty_catches

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:defenders/model/common_model/notification_payload.dart';
import 'package:path_provider_android/path_provider_android.dart' as per;
import 'package:flutter_tts/flutter_tts.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  FlutterTts flutterTts = FlutterTts();

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  per.PathProviderAndroid pathProviderAndroid = per.PathProviderAndroid();

  Future<String> getUserToken() async {
    String? value = await _fcm.getToken();
    return value!;
  }

  initLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    _fcm.subscribeToTopic('all');
  }

  Future showNotification(message) async {
    String? pushTitle;
    String? pushText;
    BigPictureStyleInformation? bigPictureStyleInformation;

    try {
      final body = jsonDecode(message["info"]);
      final NotificationPayload notificationPayload =
          NotificationPayload.fromJson(body);
      pushTitle = notificationPayload.title;
      pushText = notificationPayload.messege ?? '';

      var platformChannelSpecificsAndroid = AndroidNotificationDetails(
          'notification_app', 'your channel name',
          channelDescription: 'your channel description',
          playSound: true,
          enableVibration: false,
          fullScreenIntent: true,
          icon: '@mipmap/ic_launcher',
          sound: const RawResourceAndroidNotificationSound('nnotification'),
          importance: Importance.high,
          styleInformation: bigPictureStyleInformation,
          visibility: NotificationVisibility.public,
          priority: Priority.high);

      var platformChannelSpecifics = NotificationDetails(
          android: platformChannelSpecificsAndroid,
          iOS: const DarwinNotificationDetails());

      _flutterLocalNotificationsPlugin.show(
        0,
        pushTitle,
        pushText,
        platformChannelSpecifics,
        payload: json.encode(notificationPayload.toJson()),
      );

      try {
        // Future.delayed(const Duration(seconds: 2), () async {
        //   await flutterTts.setLanguage("en-IN");
        //   await flutterTts.setSpeechRate(0.3);
        //   await flutterTts.setVolume(1.0);
        //   await flutterTts.setPitch(1.0);
        //   await flutterTts.isLanguageAvailable("en-IN");
        //   await flutterTts.speak(pushTitle! + pushText!);
        // });
      } catch (e) {}
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
