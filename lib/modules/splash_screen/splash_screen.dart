// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:defenders/config/encryption/encryption.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/modules/splash_screen/splash_presentor.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/logo.dart';

FlutterTts flutterTts = FlutterTts();

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewPresenter presenter = BasicSplashPresenter();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      presenter.checkForceUpdateApiCall(context);
    });
    firebaseNotificationSetup();
    getLocalData();
  }

  getLocalData() async {
    if (StorageManager.getStringValue('data') != null) {
      final encodeData =
          decryptMethod(text: StorageManager.getStringValue('data')!);
      final data = json.decode(encodeData);
      GlobalSingleton.loginInfo = LoginModel.fromJson(data);

      await NetworkDio.setDynamicHeader(
        authorizationToken: GlobalSingleton.loginInfo!.refreshToken.toString(),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        //ignore: prefer_const_constructors
        Logo(),
      ],
    ));
  }
}

Future<void> firebaseNotificationSetup() async {
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  var initSetttings = InitializationSettings(
    android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestCriticalPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    ),
  );

  await FlutterLocalNotificationsPlugin().initialize(
    initSetttings,
    onDidReceiveBackgroundNotificationResponse: receiveNotification,
    onDidReceiveNotificationResponse: receiveNotification,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
    print(
      '-------->>>>>>>>>>>' + message!.notification!.title.toString(),
    );

    if (Platform.isIOS) {
      await showNotification(
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        json.encode(message.data),
      );
    }
    if (Platform.isAndroid) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;
      if (title != null && body != null) {
        await showNotification(
          title,
          body,
          json.encode(message.data),
        );
      }
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
}

Future<void> receiveNotification(NotificationResponse response) async {
  print('-------->>>>>>>>>>>' + json.decode(response.payload!).toString());
}

Future<void> onMessageOpenedApp(RemoteMessage? message) async {
  print("----->>${message!.data}");
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await showNotification(
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    json.encode(message.data),
  );
  print("Handling a background message ${message.notification?.title}");
}

Future showNotification(String title, String message, dynamic payload) async {
  final body = jsonDecode(payload);
  final bodyparam = jsonDecode(body['info']);

  await FlutterLocalNotificationsPlugin().show(
    0,
    title,
    message,
    const NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        sound: 'default',
        presentSound: true,
      ),
      android: AndroidNotificationDetails(
        'channel id',
        'channel NAME',
        channelDescription: 'CHANNEL DESCRIPTION',
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('nnotification'),
        // importance: Importance.high,
        // styleInformation: bigPictureStyleInformation,
        visibility: NotificationVisibility.public,
        fullScreenIntent: true,
        enableVibration: true,
      ),
    ),
    payload: payload,
  );
  if (bodyparam['category'] == 'Income') {
    Future.delayed(const Duration(seconds: 2), () async {
      await flutterTts.setLanguage("en-IN");
      await flutterTts.setSpeechRate(0.3);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.isLanguageAvailable("en-IN");
      await flutterTts.speak(message);
    });
  }
}
