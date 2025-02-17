// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui' as ui;
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/constants/enum.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/main.dart';
import 'package:defenders/modules/home/home_screen_model.dart';
import 'package:defenders/modules/home/home_screen_presenter.dart';
import 'package:defenders/modules/home/home_screen_view.dart';
import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
import 'package:defenders/modules/home/home_widget/marketing_screen.dart';
import 'package:defenders/modules/home/home_widget/today_task_screen.dart';
import 'package:defenders/modules/home/home_widget/user_rank_widget/home_tabel.dart';
import 'package:defenders/modules/home/home_widget/user_rank_widget/user_count_container.dart';
import 'package:defenders/modules/home/rank_team/team_rank_list_screen.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_screen.dart';
import 'package:defenders/modules/marketing/marketing_share_screen.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_screen.dart';
import 'package:defenders/modules/refer/refer_screen.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_prime_direct_screen.dart';
import 'package:defenders/utils/google_Ads.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/logo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver
    implements HomeScreenView {
  late HomeScreenModel model;
  HomeScreenPresenter presenter = BasicHomeScreenPresenter();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final CarouselSliderController featuredController =
      CarouselSliderController();
  int featuredSlideIndex = 0;
  Circle progress = Circle();
  FlutterTts flutterTts = FlutterTts();
  int todayStatusIndex = 0;
  int todayGraphicsIndex = 0;
  int mirrorPartnersIndex = 0;
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;
  final InAppReview inAppReview = InAppReview.instance;
  AppStoreTime appNameToLaunch = AppStoreTime.notStore;
  AppUpdateInfo? _updateInfo;
  GlobalKey previewContainer = GlobalKey();
  final key1 = GlobalKey();

  List<Color> graphColor = [
    Colors.orange.shade900,
    AppColors.appColors,
    Colors.green,
    Colors.orange,
    Colors.blueAccent,
    Colors.lightGreen,
    Colors.orange.shade900,
    AppColors.appColors,
    Colors.green,
    Colors.orange,
    Colors.blueAccent,
    Colors.lightGreen,
  ];
  List partnersName = [
    "Silver",
    "Gold",
    "Platium",
    "Diamond",
    "Double Diamond",
    "Ambassdor",
    "Mobile Fund",
    "Silver",
    "Gold",
    "Platium",
    "Diamond",
    "Double Diamond",
    "Ambassdor",
    "Mobile Fund",
  ];
  List<String> graphName = [
    'SL',
    'GD',
    'PLT',
    'DM',
    'DDM',
    'AMB',
    'SL',
    'GD',
    'PLT',
    'DM',
    'DDM',
    'AMB'
  ];

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    WidgetsBinding.instance.addObserver(this);

    checkAllPermission();

    presenter.getWalletBalance(
        userID: GlobalSingleton.loginInfo!.data!.id.toString());
    presenter.getCompanyGraph(context: context);
    presenter.getGraphics(context: context);
    presenter.getRankWiseTeam();
    presenter.getProfile(context: context);
    presenter.getTotalCount(context: context);

    presenter.getGraphicsData(
        catId: model.categoriesIdList[DateTime.now().hour]['id'], page: 1);
    getUserToken();
    if (GlobalSingleton.bannerList == null) {
      presenter.getBanner();
      Future.delayed(const Duration(seconds: 0), () {
        // showMirrorSubscribeDialog();
        showDialogWidget();
      });
    }
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    log("$res: OVERLAY");
    _receivePort.listen((message) {
      log("message from OVERLAY: $message");
      setState(() {
        latestMessageFromOverlay = 'Latest Message From Overlay: $message';
      });
    });
  }

  showDialogWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int appCount = prefs.getInt('appOpenfordialog') ?? 0;

    if (appCount <= 1) {
      // isShowGif = true;

      presenter.getNotification(context: context);
    } else {
      // isShowGif = false;
    }
    appCount++;
    if (prefs.getInt('appOpenLastTimefordialog') == null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt('appOpenLastTimefordialog', timestamp);
    }
    int timestamp = prefs.getInt('appOpenLastTimefordialog') ??
        DateTime.now().millisecondsSinceEpoch;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (DateTime.now().difference(dateTime).inDays == 1) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt('appOpenLastTimefordialog', timestamp);
      prefs.setInt('appOpenfordialog', 0);
    } else {
      prefs.setInt('appOpenfordialog', appCount);
    }
    setState(() {});
  }

  Future<void> requestReview() async {
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      print('----');
      // Handle the case when in-app reviews are not available, such as on iOS versions prior to iOS 10.3 or Android devices without Play Store.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      getTimeFunction();
    } else if (state == AppLifecycleState.paused) {
      timeStoreFunction();
    }
  }

  showMirrorSubscribeDialog() {
    if (StorageManager.getIntValue('showMirrorSubscribeDialog') == null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      StorageManager.setIntValue(
          key: 'showMirrorSubscribeDialog', value: timestamp);
      if (StorageManager.getBoolValue(AppStoreTime.youtube.toString()) !=
          true) {
        StorageManager.setIntValue(
            key: 'YoutbeDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        youtubeDialog();
      } else if (StorageManager.getBoolValue(
              AppStoreTime.instagram.toString()) !=
          true) {
        instagramDialog();
      } else if (StorageManager.getBoolValue(
              AppStoreTime.telegram.toString()) !=
          true) {
        telegramDialog();
      }
    } else {
      //YouTube
      DateTime youtubeStoreTime = DateTime.fromMillisecondsSinceEpoch(
          StorageManager.getIntValue('YoutbeDialogShowTime') ?? 0);
      int youtubesubscribedDialog =
          DateTime.now().difference(youtubeStoreTime).inDays;
      // Instagram
      DateTime instaStoreTime = DateTime.fromMillisecondsSinceEpoch(
          StorageManager.getIntValue('InstagramDialogShowTime') ?? 0);
      int instasubscribedDialog =
          DateTime.now().difference(instaStoreTime).inDays;
      //Telegram
      DateTime telegramStoreTime = DateTime.fromMillisecondsSinceEpoch(
          StorageManager.getIntValue('TelegramDialogShowTime') ?? 0);
      int telegramsubscribedDialog =
          DateTime.now().difference(telegramStoreTime).inDays;
      if (youtubesubscribedDialog > 60 &&
          StorageManager.getBoolValue(AppStoreTime.youtube.toString()) !=
              true) {
        StorageManager.setIntValue(
            key: 'YoutbeDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        youtubeDialog();
      } else if (youtubesubscribedDialog > 1 &&
          instasubscribedDialog > 60 &&
          StorageManager.getBoolValue(AppStoreTime.instagram.toString()) !=
              true) {
        StorageManager.setIntValue(
            key: 'InstagramDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        instagramDialog();
      } else if (youtubesubscribedDialog > 1 &&
          instasubscribedDialog > 1 &&
          telegramsubscribedDialog > 60 &&
          StorageManager.getBoolValue(AppStoreTime.telegram.toString()) !=
              true) {
        StorageManager.setIntValue(
            key: 'TelegramDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        telegramDialog();
      }
    }
  }

  timeStoreFunction() {
    StorageManager.clearKey('youtubeStoreTime');
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    StorageManager.setIntValue(key: 'youtubeStoreTime', value: timestamp);
  }

  getTimeFunction() {
    DateTime youtubeStoreTime = DateTime.fromMillisecondsSinceEpoch(
        StorageManager.getIntValue('youtubeStoreTime') ?? 0);
    int youtubeSecound = DateTime.now().difference(youtubeStoreTime).inSeconds;

    if (youtubeSecound > 5) {
      if (appNameToLaunch == AppStoreTime.youtube) {
        log("youtube appNameToLaunch");
        StorageManager.setBoolValue(
            key: AppStoreTime.youtube.toString(), value: true);

        // instagramDialog();
      } else if (appNameToLaunch == AppStoreTime.instagram) {
        log("instagram appNameToLaunch");
        StorageManager.setBoolValue(
            key: AppStoreTime.instagram.toString(), value: true);
        // telegramDialog();
      } else {
        log("other appNameToLaunch");
        StorageManager.setBoolValue(
            key: AppStoreTime.telegram.toString(), value: true);
      }
    } else {
      if (appNameToLaunch == AppStoreTime.youtube) {
        log("youtube appNameToLaunch else");
        StorageManager.setIntValue(
            key: 'YoutbeDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        // youtubeDialog();
      } else if (appNameToLaunch == AppStoreTime.instagram) {
        log("instagram appNameToLaunch else");
        StorageManager.setIntValue(
            key: 'InstagramDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        // instagramDialog();
      } else if (appNameToLaunch == AppStoreTime.telegram) {
        log("telegram appNameToLaunch else");
        StorageManager.setIntValue(
            key: 'TelegramDialogShowTime',
            value: DateTime.now().millisecondsSinceEpoch);
        // telegramDialog();
      }
    }
  }

  youtubeDialog() {
    // log("$dd Youtube");
    dialogData(
        appName: 'Youtube',
        appUrl: '',
        imageUrl: AppAssets.yt,
        onTap: () async {
          appNameToLaunch = AppStoreTime.youtube;
          if (!await launchUrl(
            Uri.parse(
              'https://youtube.com/channel/UCd1HlEJMcTP7EiKww7AAbjw',
            ),
            mode: LaunchMode.externalApplication,
          ).then((value) {
            Navigator.pop(context);
            return false;
          })) {}
        });
  }

  instagramDialog() {
    // log("$ll Instagram");
    dialogData(
        appName: 'Instagram',
        appUrl: '',
        imageUrl: AppAssets.insta,
        onTap: () async {
          appNameToLaunch = AppStoreTime.instagram;
          if (!await launchUrl(
            Uri.parse(
                'https://www.instagram.com/_mirror_official?igsh=MWVzMDZxdTl5ZHo2cg%3D%3D'),
            mode: LaunchMode.externalApplication,
          ).then((value) {
            Navigator.pop(context);
            return false;
          })) {}
        });
  }

  telegramDialog() {
    // log("$kk Telegram");
    dialogData(
        appName: 'Telegram',
        appUrl: '',
        imageUrl: AppAssets.teleg,
        onTap: () async {
          appNameToLaunch = AppStoreTime.telegram;
          if (!await launchUrl(
            Uri.parse('https://t.me/mirrorinfotech'),
            mode: LaunchMode.externalApplication,
          ).then((value) {
            Navigator.pop(context);
            return false;
          })) {}
        });
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;

        if (_updateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          forceUpdateDialog(context);
        }
      });
    }).catchError((e) {
      // showSnack(e.toString());
    });
  }

  checkAllPermission() async {
    await requestReview();
    checkForUpdate();
    PermissionStatus notificationPermission =
        await Permission.notification.status;

    if (notificationPermission.isPermanentlyDenied ||
        notificationPermission.isDenied) {
      Permission.notification.request();

      // permissionDialogData();
    }
    await Permission.sms.request();
    await Permission.phone.request();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  void refreshModel(HomeScreenModel homeModel) {
    model = homeModel;
    if (mounted) {
      setState(() {});
    }
  }

  getUserToken() async {
    String? value = await _fcm.getToken();
    presenter.registerToken(token: value.toString());
  }

  final colorList = <Color>[
    AppColors.appColors,
    AppColors.secoundColors,
  ];

  _share(imageUrl) async {
    var url = imageUrl.toString();
    var response = await get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    await Share.shareXFiles([XFile(filePathAndName)]);
  }

  dialogData(
      {required String appName,
      required String appUrl,
      required String imageUrl,
      required void Function()? onTap}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.appColors,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(6, 6),
                              blurRadius: 15.0,
                              color: Color.fromARGB(255, 132, 179, 202),
                              spreadRadius: 1)
                        ]),
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20),
                        child: Image.asset(
                          AppAssets.appLogo,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        imageUrl,
                        height: 50,
                        width: 59,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Subscribe Our Mirror $appName Channel',
                          style: AppTextStyle.semiBold16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.appColors),
                        child: Text(
                          'Subscribe Now',
                          style: AppTextStyle.regular14
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (GlobalSingleton.bannerList != null &&
                GlobalSingleton.bannerList!.isNotEmpty)
              Banners(
                model: (GlobalSingleton.bannerList != null)
                    ? GlobalSingleton.bannerList ?? []
                    : null,
              ),
            // InkWell(
            //   onTap: () async {
            //     // await flutterTts.setLanguage("en-IN");
            //     // await flutterTts.setSpeechRate(0.3);
            //     // await flutterTts.setVolume(1.0);
            //     // await flutterTts.setPitch(1.0);
            //     // await flutterTts.isLanguageAvailable("en-IN");
            //     // await flutterTts.speak('Hello Jatin ');
            //     http.Response response = await http.post(
            //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
            //       headers: <String, String>{
            //         'Content-Type': 'application/json',
            //         'Authorization':
            //             'key=AAAA-FJ2yYU:APA91bG1palCKFisKGPvbJZrlMZi95PjBAuBzBrT97_CDf0j973I0AebZnRIRQY8wOX8svAJDF8OeBVybCdy3f9wAo5yjXAt-U8OoCUZ2vZOnVHZScB_Gfn3bi8_mH2B8LTIg6G99XTg',
            //       },
            //       body: jsonEncode(
            //         <String, dynamic>{
            //           'notification': <String, dynamic>{
            //             'body': 'Hello Mirror Infotech',
            //             'title': 'this is a title'
            //           },
            //           "priority": "high",
            //           "data": <String, dynamic>{
            //             "click_action": "FLUTTER_NOTIFICATION_CLICK",
            //             "id": "1",
            //             "status": "done",
            //             "info": {
            //               "title": "title",
            //               "link": "link",
            //               "image": "image",
            //               "body": "body",
            //               "category": "Income",
            //             },
            //           },
            //           "to":
            //               "cyQCae_7S-mrCcuYqDRq1m:APA91bGuOjZ-8FkDciAOV03HbIYJXy27N8jETFypAlxGQ1W6ZQ0ZwBOLrrL_Q5vnO13aGkhVF6-jUqyLowZTLRBpGX8O-ckA8ur-L27FwzPuikndfEdZuwcvUq7Bcgch_maap9UHV_6h",
            //         },
            //       ),
            //     );

            //     print('+++++++++${response}++');
            //   },
            //   child: const SizedBox(
            //     height: AppSizes.size80,
            //   ),
            // ),
            const GoogleAdsScreen(),

            // InkWell(
            //   onTap: () async {

            //     // forceUpdateDialog(context);
            //     // await FlutterOverlayWindow.showOverlay(
            //     //     height: (MediaQuery.of(context).size.height * 2.6).round());

            //     // Future.delayed(const Duration(seconds: 5), () async {
            //     //   await FlutterOverlayWindow.closeOverlay();
            //     // });
            //   },
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.red,
            //   ),
            // ),
            // InkWell(
            //    onTap: () => Scrollable.ensureVisible(key1.currentContext!),
            //   // onTap: () async {
            //   //   //  Scrollable.ensureVisible(key1.currentContext!);
            //   //   Navigator.push(context,
            //   //       MaterialPageRoute(builder: (context) => ScrollView()));
            //   // },
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.yellow,
            //   ),
            // ),

            const SizedBox(
              height: AppSizes.size10,
            ),

            // const SizedBox(
            //   height: AppSizes.size10,
            // ),
            walletBalanceService(),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodayPrimeDirectScreen(
                            isFromPrime: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyColor)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.sale,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                (model.todayData.primeCount ?? 0).toString(),
                                style: AppTextStyle.semiBold20,
                              ),
                            ],
                          ),
                          const Text('Today Prime'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // dialogData();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodayPrimeDirectScreen(
                            isFromPrime: false,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyColor)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.todayRefer,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                (model.todayData.teamCount ?? 0).toString(),
                                style: AppTextStyle.semiBold20
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ],
                          ),
                          const Text('Today Direct Join'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),

            TodayTaskWidget(
              graphicsList: model.todayList,
            ),
            // MarketingWidget(
            //   graphicsList: model.graphicsList ?? [],
            //   isTodayTask: true,
            // ),
            const SizedBox(
              height: 10,
            ),
            if (model.graphicsList.todaysStatus != null &&
                model.graphicsList.todaysStatus!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstString.todayStatus.tr(),
                      style: AppTextStyle.semiBold18,
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (model.graphicsList.todaysStatus != null &&
                model.graphicsList.todaysStatus!.isNotEmpty)
              const SizedBox(
                height: AppSizes.size6,
              ),

            if (model.graphicsList.todaysStatus != null &&
                model.graphicsList.todaysStatus!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CarouselSlider.builder(
                    itemCount: model.graphicsList.todaysStatus!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      todayStatusIndex = itemIndex;

                      return InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              'https://secure.mirror.org.in/${model.graphicsList.todaysStatus![itemIndex].image}'),
                        ),
                      );
                    },
                    options: CommonMethod.carouselOptions(
                        size: 160,
                        onChanged: (val, dia) {
                          setState(() {});
                        })),
              ),
            const SizedBox(
              height: 10,
            ),
            if (model.graphicsList.todaysStatus != null &&
                model.graphicsList.todaysStatus!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedSmoothIndicator(
                      activeIndex: todayStatusIndex,
                      count: model.graphicsList.todaysStatus!.length,
                      effect: const ExpandingDotsEffect(
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          activeDotColor: AppColors.secoundColors),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List.generate(
                  //     model.graphicsList.todaysStatus!.length,
                  //     (index) => Container(
                  //       height: 10,
                  //       width: 10,
                  //       margin: const EdgeInsets.symmetric(horizontal: 5),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: todayStatusIndex == index
                  //               ? AppColors.appColors
                  //               : Colors.grey),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                      onTap: () {
                        _share(
                            "https://secure.mirror.org.in/${model.graphicsList.todaysStatus![0].image}");
                      },
                      child: const Icon(Icons.share))
                ],
              ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.categoriesIdList[DateTime.now().hour]['Name'],
                    style: AppTextStyle.semiBold18,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MarketingSubCatgoriesScreen(
                            categoriesID: model
                                .categoriesIdList[DateTime.now().hour]['id'],
                            categoriesName: model
                                .categoriesIdList[DateTime.now().hour]['Name'],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View All',
                      style: AppTextStyle.semiBold14
                          .copyWith(color: AppColors.appColors),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            CarouselSlider(
              carouselController: featuredController,
              options: CarouselOptions(
                aspectRatio: 1.45,
                viewportFraction: .45,
                enableInfiniteScroll: true,
                disableCenter: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                onPageChanged: (index, reason) {
                  setState(() {
                    featuredSlideIndex = index;
                  });
                },
              ),
              items: List.generate(model.graphicsdata.length, (index) {
                // todayGraphicsIndex = index;
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appColors),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GraphicsShareScreen(
                            categoriesImage:
                                model.graphicsdata[index].image.toString(),
                            isImageUrlFull: false,
                            categoriesName: model
                                .graphicsdata[index].graphicsName
                                .toString(),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: 160,
                            height: 170,
                            imageUrl:
                                "https://secure.mirror.org.in/${model.graphicsdata[index].image}",
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: AppColors.secoundColors,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            model.graphicsdata[index].graphicsName.toString(),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  _share(
                                      "https://secure.mirror.org.in/${model.graphicsdata[index].image}");
                                  model.graphicsdata[index].shareCount =
                                      ((model.graphicsdata[index].shareCount ??
                                              0) +
                                          1);

                                  presenter.updateLike(
                                      id: model.graphicsdata[index].id
                                          .toString(),
                                      action: 'Share');
                                  setState(() {});
                                },
                                child: const Icon(Icons.share_outlined)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.graphicsdata[index].shareCount.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  model.graphicsdata[index].likeCount =
                                      ((model.graphicsdata[index].likeCount ??
                                              0) +
                                          1);
                                  presenter.updateLike(
                                      id: model.graphicsdata[index].id
                                          .toString(),
                                      action: 'Like');
                                  setState(() {});
                                },
                                child: const Icon(Icons.favorite)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.graphicsdata[index].likeCount.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedSmoothIndicator(
                activeIndex: featuredSlideIndex,
                count: model.graphicsdata.length,
                effect: const ExpandingDotsEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: AppColors.secoundColors),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(
            //     model.graphicsdata.length,
            //     (index) => Container(
            //       height: 10,
            //       width: 10,
            //       margin: const EdgeInsets.symmetric(horizontal: 5),
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: featuredSlideIndex == index
            //               ? AppColors.appColors
            //               : Colors.grey),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: AppSizes.size10,
            ),

            MarketingWidget(
              graphicsList: model.graphicsList.data ?? [],
              isTodayTask: false,
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            const SizedBox(
              height: 20,
            ),

            RepaintBoundary(
              key: previewContainer,
              child: Container(
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        key: key1,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppConstString.myProgress.tr(),
                            style: AppTextStyle.semiBold18,
                          ),
                        ],
                      ),
                    ),

                    if (model.dataMap != null)
                      Row(
                        children: [
                          PieChart(
                            dataMap: model.dataMap!,

                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,

                            chartRadius:
                                MediaQuery.of(context).size.width / 2.3,
                            colorList: colorList,
                            initialAngleInDegree: 270,
                            chartType: ChartType.disc,
                            ringStrokeWidth: 20,
                            // centerText: "HYBRID",
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              // legendPosition: LegendPosition.right,
                              showLegends: false,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                                chartValueStyle: AppTextStyle.semiBold16),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${model.graphData[model.selectedGraphData].category}',
                                  style: AppTextStyle.semiBold14,
                                ),
                                Text(
                                  "${AppConstString.rupeesSymbol}${double.parse(model.graphData[model.selectedGraphData].rankAchievverAmount ?? '0').floor()}",
                                  style: AppTextStyle.semiBold22
                                      .copyWith(color: AppColors.sucessGreen),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${AppConstString.rupeesSymbol}${double.parse(model.graphData[model.selectedGraphData].receivedIncome ?? '0').floor()}",
                                      style: AppTextStyle.semiBold14
                                          .copyWith(color: AppColors.appColors),
                                    ),
                                    Text(
                                      '/',
                                      style: AppTextStyle.regular14,
                                    ),
                                    Text(
                                      (double.parse(model
                                                      .graphData[model
                                                          .selectedGraphData]
                                                      .rankAchievverAmount ??
                                                  "0") -
                                              double.parse(model
                                                      .graphData[model
                                                          .selectedGraphData]
                                                      .receivedIncome ??
                                                  "0"))
                                          .toString(),
                                      // " ${double.parse(model.graphData[model.selectedGraphData].rankAchievverAmount ?? '0').floor()}",
                                      style: AppTextStyle.semiBold14.copyWith(
                                          color: AppColors.secoundColors),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizes.size10,
                                ),
                                Text(
                                  'Total Business',
                                  style: AppTextStyle.semiBold14,
                                ),
                                const SizedBox(
                                  height: AppSizes.size6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 30,
                                      margin: const EdgeInsets.only(right: 10),
                                      color: AppColors.appColors,
                                    ),
                                    const Expanded(
                                        child: Text('Achieve Business'))
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizes.size6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 30,
                                      margin: const EdgeInsets.only(right: 10),
                                      color: AppColors.secoundColors,
                                    ),
                                    const Expanded(
                                        child: Text('Remaining Business'))
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizes.size6,
                                ),
                                // PrimaryButton(
                                //   text: 'View',
                                //   height: 35,
                                //   width: 150,
                                //   gradient: AppColors.organeCircleGradient,
                                //   textStyle: AppTextStyle.semiBold16
                                //       .copyWith(color: AppColors.whiteColor),
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: AppSizes.size20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Rank Achievement Graph ',
                            style: AppTextStyle.semiBold18,
                          ),
                          InkWell(
                            onTap: () {
                              _imageShare();
                            },
                            child: const Icon(
                              Icons.share,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (model.dataMap != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "My Rank",
                              style: AppTextStyle.semiBold14,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              GlobalSingleton.rank == 'null'
                                  ? 'Distributor'
                                  : GlobalSingleton.rank,
                              style: AppTextStyle.semiBold16
                                  .copyWith(color: AppColors.secoundColors),
                            ),
                          ],
                        ),
                      ),
                    // if (model.dataMap != null)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             (double.parse(model.graphData[model.selectedGraphData]
                    //                             .rankAchievverAmount ??
                    //                         "0") -
                    //                     double.parse(model
                    //                             .graphData[model.selectedGraphData]
                    //                             .receivedIncome ??
                    //                         "0"))
                    //                 .toString(),
                    //             // "${AppConstString.rupeesSymbol}${double.parse(model.graphData[model.selectedGraphData].rankAchievverAmount ?? '0').floor()}",
                    //             style: AppTextStyle.regular14
                    //                 .copyWith(color: AppColors.successColor),
                    //           ),
                    //           Text(
                    //             "${AppConstString.rupeesSymbol}${double.parse(model.graphData[model.selectedGraphData].receivedIncome ?? '0').floor()}",
                    //             textAlign: TextAlign.center,
                    //             style: AppTextStyle.regular20
                    //                 .copyWith(color: AppColors.appColors),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),

                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),

                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    if (model.graphData.isNotEmpty)
                      Center(
                        child: SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          series: <CartesianSeries>[
                            BarSeries<SalesData, String>(
                              dataSource: List.generate(
                                model.graphData.length,
                                (index) => SalesData(
                                    // model.graphData[index].rank!.length > 2
                                    //     ? ("${model.graphData[index].rank}"
                                    //         .substring(0, 3))
                                    //     :
                                    ("${model.graphData[index].rank}"
                                        .substring(0, 2)),
                                    // Split the string into words
                                    // double.parse(
                                    //     model.graphData[index].receivedIncome ?? "0"),
                                    (model.selectedGraphData >= index)
                                        ? double.parse(model.graphData[index]
                                                .receivedIncome ??
                                            "0")
                                        : 0,
                                    // (index != 0)
                                    //     ? (model.graphData[index - 1].category ==
                                    //             model.graphData[index - 1]
                                    //                 .rankAchieverCategory
                                    //         // model.graphData[index - 1]
                                    //         //     .targetAchievverAmount

                                    //         )
                                    //         ? double.parse(model.graphData[index].receivedIncome ?? "0") >
                                    //                 double.parse(model
                                    //                         .graphData[index]
                                    //                         .rankAchievverAmount ??
                                    //                     "0")
                                    //             ? double.parse(model
                                    //                     .graphData[index]
                                    //                     .rankAchievverAmount ??
                                    //                 "0")
                                    //             : double.parse(model
                                    //                     .graphData[index]
                                    //                     .receivedIncome ??
                                    //                 "0")
                                    //         : 0
                                    //     : model.graphData[index].category !=
                                    //             // model.graphData[index]
                                    //             //     .targetAchievverAmount
                                    //             model.graphData[index]
                                    //                 .rankAchieverCategory
                                    //         ? double.parse(model.graphData[index].receivedIncome ?? "0")
                                    //         : double.parse(model.graphData[index].rankAchievverAmount ?? "0"),
                                    graphColor[index]),
                              ),
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              pointColorMapper: (SalesData sales, _) =>
                                  sales.color,
                              width: 0.3,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                color: AppColors.backgroundColor,
                                connectorLineSettings:
                                    ConnectorLineSettings(width: 10),
                                margin: EdgeInsets.zero,
                              ),
                            ),
                          ],
                          isTransposed: true,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appColors),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade900,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Silver Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.appColors,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            // 'Gold Rank',
                            "Mobile Fund",
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Car Fund",
                            // 'Double Diamond Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Gold Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'House Fund',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Platinum Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade900,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Travel Fund',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.appColors,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Diamond Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Community Fund',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Double Diamond Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Ambassdor Rank',
                            style: AppTextStyle.semiBold12,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              // clipBehavior: Clip.none,
              children: [
                InkWell(
                    onTap: () async {
                      CommonMethod()
                          .getUserLog(action: 'Business_Refer_link', id: 9);
                      CommonMethod.referLink(
                          referCode: GlobalSingleton.loginInfo!.data!.mobile
                              .toString(),
                          name:
                              "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
                      // await LaunchApp.openApp(
                      //   androidPackageName: 'com.mirrorinfo',
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        AppAssets.referFriend,
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    )),
                Container(
                  // padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 300, left: 14, right: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.appColors)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Mirror Partners',
                          style: AppTextStyle.semiBold18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (model.silverDetailsResponse.data != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: CarouselSlider.builder(
                              itemCount: model
                                  .silverDetailsResponse.totalCount!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UserCountContainer(
                                    color: const Color(0xFFD9D9D9),
                                    isSelectedTab:
                                        itemIndex == mirrorPartnersIndex
                                            ? true
                                            : false,
                                    text:
                                        "${model.silverDetailsResponse.totalCount![itemIndex].rank} (${model.silverDetailsResponse.totalCount![itemIndex].totalRank})",
                                    onTap: () {
                                      model.tabelName = model
                                          .silverDetailsResponse
                                          .totalCount![itemIndex]
                                          .rank
                                          .toString();
                                      model.tabindex = itemIndex;

                                      setState(() {});
                                    },
                                    usercountgradient:
                                        const LinearGradient(colors: [
                                      Color(0xFFD9D9D9),
                                      Color(0xFF6D6D6D),
                                    ]),
                                    image: 'silver.png',
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  height: 160,
                                  aspectRatio: 1.45,
                                  viewportFraction: .45,
                                  enableInfiniteScroll: true,
                                  disableCenter: false,
                                  // padEnds: false,
                                  autoPlay: true,
                                  // autoPlayInterval: const Duration(seconds: 30),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 3),
                                  onPageChanged: (val, dia) {
                                    model.tabelName = model
                                        .silverDetailsResponse
                                        .totalCount![val]
                                        .rank
                                        .toString();
                                    model.tabindex = val;
                                    mirrorPartnersIndex = val;
                                    setState(() {});
                                  })),
                        ),
                      // SizedBox(
                      //   height: 155,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       shrinkWrap: true,
                      //       itemCount: model
                      //           .silverDetailsResponse.totalCount!.length,
                      //       itemBuilder: (context, index) {
                      //         return Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: UserCountContainer(
                      //             color: const Color(0xFFD9D9D9),
                      //             isSelectedTab:
                      //                 index == model.tabindex ? true : false,
                      //             text:
                      //                 "${model.silverDetailsResponse.totalCount![index].rank} (${model.silverDetailsResponse.totalCount![index].totalRank})",

                      //             onTap: () {
                      //               model.tabelName = model
                      //                   .silverDetailsResponse
                      //                   .totalCount![index]
                      //                   .rank
                      //                   .toString();
                      //               model.tabindex = index;

                      //               setState(() {});
                      //             },
                      //             usercountgradient:
                      //                 const LinearGradient(colors: [
                      //               Color(0xFFD9D9D9),
                      //               Color(0xFF6D6D6D),
                      //             ]),
                      //             image: 'silver.png',
                      //           ),
                      //         );
                      //       }),
                      // ),
                      // rankTabDesign(),
                      if (model.silverDetailsResponse.data != null)
                        HomeTabel(
                          tabelName: model.tabelName,
                          rank: model.silverDetailsResponse
                                  .totalCount![model.tabindex].totalRank ??
                              0,

                          silverDetailsResponse: "Silver" == model.tabelName
                              ? model.silverDetailsResponse.data![0].silver ??
                                  []
                              : "Gold" == model.tabelName
                                  ? model.silverDetailsResponse.data![1].gold ??
                                      []
                                  : "Platinum" == model.tabelName
                                      ? model.silverDetailsResponse.data![3]
                                              .platinum ??
                                          []
                                      : "Diamond" == model.tabelName
                                          ? model.silverDetailsResponse.data![5]
                                                  .diamond ??
                                              []
                                          : "Double Diamond" == model.tabelName
                                              ? model.silverDetailsResponse
                                                      .data![6].doubleDiamond ??
                                                  []
                                              : "Ambassdor" == model.tabelName
                                                  ? model.silverDetailsResponse
                                                          .data![8].ambassdor ??
                                                      []
                                                  : "Mobile Fund" ==
                                                          model.tabelName
                                                      ? model
                                                              .silverDetailsResponse
                                                              .data![10]
                                                              .mobileFund ??
                                                          []
                                                      : "Car Fund" ==
                                                              model.tabelName
                                                          ? model
                                                                  .silverDetailsResponse
                                                                  .data![2]
                                                                  .carFund ??
                                                              []
                                                          : "Travel Fund" ==
                                                                  model
                                                                      .tabelName
                                                              ? model
                                                                      .silverDetailsResponse
                                                                      .data![7]
                                                                      .travelFund ??
                                                                  []
                                                              : "Community Fund" ==
                                                                      model
                                                                          .tabelName
                                                                  ? model
                                                                          .silverDetailsResponse
                                                                          .data![9]
                                                                          .communityFund ??
                                                                      []
                                                                  : "House Fund" == model.tabelName
                                                                      ? model.silverDetailsResponse.data![4].houseFund ?? []
                                                                      : [],
                          //  model.tabelName == 'GOLD'
                          //     ? (model.silverDetailsResponse.data![1].gold ?? [])
                          //     : model.tabelName == "Platinum"
                          //         ? (model.silverDetailsResponse.data![2]
                          //                 .platinum ??
                          //             [])
                          //         : (model.silverDetailsResponse.data!.first
                          //                 .silver ??
                          //             []),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TeamRankListScreen(
                                              rank: model.tabelName.toString(),
                                              rankCount: (model
                                                      .silverDetailsResponse
                                                      .totalCount![
                                                          model.tabindex]
                                                      .totalRank ??
                                                  0),
                                            )));
                              },
                              child: const Text(
                                'View All',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.appColors,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            connectWithUsService(),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appColors, width: 2)),
                  child: Column(
                    children: [
                      Text(
                        "Need help? Contact our support team for prompt assistance and expert guidance.",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.appColors),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(AppAssets.callSupport),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: PrimaryButton(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                      ),
                                      insetPadding: const EdgeInsets.all(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const GoogleAdsScreen(),
                                            RechargeContainer(
                                                title: 'Connect with us',
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: List.generate(
                                                    mirrorConnectList.length,
                                                    (index) => servicesIconDrawerWidget(
                                                        title:
                                                            mirrorConnectList[
                                                                index]['title'],
                                                        data: const [],
                                                        imageurl:
                                                            mirrorConnectList[
                                                                    index]
                                                                ['imageUrl'],
                                                        onPress:
                                                            mirrorConnectList[
                                                                    index]
                                                                ['function']),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            text: 'Help & Support'),
                      )
                    ],
                  ),
                ),

                // Positioned(
                //   right: 0,
                //   top: 0,
                //   child: InkWell(
                //       onTap: () {
                //         // const number = AppConstString.supportNumber;
                //         // CommonMethod.whatsapp(mobileNumber: number);
                //         showDialog(
                //             context: context,
                //             builder: (context) {
                //               return Dialog(
                //                 shape: const RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(32.0),
                //                   ),
                //                 ),
                //                 insetPadding: const EdgeInsets.all(10),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       RechargeContainer(
                //                           title: 'Connect with us',
                //                           child: Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: List.generate(
                //                               mirrorConnectList.length,
                //                               (index) => servicesIconDrawerWidget(
                //                                   title: mirrorConnectList[index]
                //                                       ['title'],
                //                                   data: const [],
                //                                   imageurl:
                //                                       mirrorConnectList[index]
                //                                           ['imageUrl'],
                //                                   onPress:
                //                                       mirrorConnectList[index]
                //                                           ['function']),
                //                             ),
                //                           )),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             });
                //       },
                //       child: const SizedBox(
                //         height: 250,
                //         width: 250,
                //       )),
                // )
              ],
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            if (Platform.isAndroid)
              const SizedBox(
                // height: 30,
                child: Align(
                  //padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Ver ${AppConstString.appVersion}",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            letterSpacing: 0.8),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "App Designed and Developed by MirrorInfo Tech Pvt Ltd",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              letterSpacing: 0.8),
                        ),
                      ),
                      Text(
                        AppConstString.ownersNumber,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            letterSpacing: 0.8),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _imageShare() async {
    progress.show(context);
    try {
      final RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/home_graph.jpeg').create();
      await imagePath.writeAsBytes(pngBytes);
      await Share.shareXFiles([XFile(imagePath.path)]);
      // await ImageGallerySaver.saveImage(pngBytes);
      //        await Share.shareFiles([imagePath.path]);
      //   NetworkDio.showSuccess(
      //     title: AppConstString.success,
      //     context: context,
      //     sucessMessage: AppConstString.imageStored,
      //   );
    } catch (e) {}
    progress.hide(context);
    // try {
    //   pixelRatio = math.max(heightRatio, widthRatio);

    //   await screenshotController
    //       .capture(
    //           pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
    //       .then((image) async {
    //     if (image != null) {
    //       final directory = await getApplicationDocumentsDirectory();
    //       final imagePath = await File('${directory.path}/image.jpeg').create();
    //       await imagePath.writeAsBytes(image);
    //       await Share.shareFiles([imagePath.path]);
    //     }
    //   });
    // } catch (e) {}
  }

  Widget connectWithUsService() {
    return RechargeContainer(
        title: 'Connect with us',
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                model.mirrorConnectList.length,
                (index) => ServicesIconWidget(
                    title: model.mirrorConnectList[index]['title'],
                    data: const [],
                    imageFullPath: true,
                    imageurl: model.mirrorConnectList[index]['image_url'],
                    extraFunction: () {},
                    onPress: model.mirrorConnectList[index]['functions']),
              ),
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PrimaryButton(
                width: 200,
                onTap: () {
                  appRouter.push(const FeedbackScreenRoute());
                },
                text: 'Create Ticket',
              ),
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
          ],
        ));
  }

  void forceUpdateDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          AppAssets.appUpdate,
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                ),
                Text(
                  'Update ${AppConstString.appName}',
                  style: AppTextStyle.semiBold18,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${AppConstString.appName} recommends that you update to the latest version.',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      InAppUpdate.performImmediateUpdate();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.appColors),
                      child: Text(
                        'Update Now',
                        style: AppTextStyle.regular14
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // actions: <Widget>[
  //   TextButton(
  //     onPressed: () {
  //       // Start the update process
  //       InAppUpdate.performImmediateUpdate();
  //       Navigator.of(context).pop();
  //     },
  //     child: Text('Update'),
  //   ),
  // ],

  Widget walletBalanceService() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Logo(
                hight: 40,
                imageUrl: GlobalSingleton.profilePic,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MarketingDashboardScreen(
                            isFromMainScreen: false,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientText(
                        "${greeting()}...",
                        style: AppTextStyle.semiBold18,
                        gradient: const LinearGradient(colors: [
                          Color(0xff101A33),
                          Color(0xff618DEC),
                        ]),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MarketingDashboardScreen(
                            isFromMainScreen: false,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientText(
                        "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}..!",
                        style: AppTextStyle.semiBold26,
                        gradient: const LinearGradient(colors: [
                          Color(0xff101A33),
                          Color(0xff618DEC),
                        ]),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${GlobalSingleton.loginInfo!.data!.mobile} | ${GlobalSingleton.loginInfo!.data!.mlmId}",
                        style: AppTextStyle.regular16,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.size10, vertical: 15),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.cardBlue), fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstString.walletBalance.tr(),
                      style: AppTextStyle.semiBold14,
                    ),
                    const SizedBox(
                      height: AppSizes.size6,
                    ),
                    Text(
                      '${AppConstString.rupeesSymbol} ${GlobalSingleton.walletBalance}',
                      style: AppTextStyle.bold20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstString.cashbackPoint.tr(),
                      style: AppTextStyle.semiBold14,
                    ),
                    const SizedBox(
                      height: AppSizes.size6,
                    ),
                    Text(
                      '${AppConstString.rupeesSymbol} ${GlobalSingleton.cashbackWallet}',
                      style: AppTextStyle.bold20,
                      // .copyWith(color: AppColors.secoundColors),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.router.pushAndPopUntil(
                      MainHomeScreenRoute(isFromSignup: false),
                      predicate: (route) => false,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appColors),
                          child: const Icon(
                            Icons.refresh,
                            color: AppColors.whiteColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Refresh',
                          style: AppTextStyle.regular12,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(8),
            // margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightBlueColor,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(
                                          IncomePassbookScreenRoute(
                                              isFromDrawer: true));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total \nEarning',
                                          style: AppTextStyle.regular16,
                                        ),
                                        Text(
                                          formatAmount(
                                              model.totalEarning.toString()),
                                          maxLines: 1,
                                          style: AppTextStyle.regular20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(
                                          IncomePassbookScreenRoute(
                                              isFromDrawer: true));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Today's \nEarning",
                                          style: AppTextStyle.regular16,
                                        ),
                                        Text(
                                          formatAmount(
                                              model.todayIncome.toString()),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyle.regular20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    if (model.dataMap != null)
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                Scrollable.ensureVisible(key1.currentContext!),
                            child: PieChart(
                              dataMap: model.dataMap!,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,

                              chartRadius:
                                  MediaQuery.of(context).size.width / 3,
                              colorList: colorList,
                              initialAngleInDegree: 270,
                              chartType: ChartType.disc,
                              ringStrokeWidth: 20,
                              // centerText: "HYBRID",
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                // legendPosition: LegendPosition.right,
                                showLegends: false,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: true,
                                  showChartValuesInPercentage: true,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                  chartValueStyle: AppTextStyle.semiBold16),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      height: 35,
                      width: 110,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReferScreen(),
                          ),
                        );
                      },
                      text: 'Refer Now',
                      textStyle: AppTextStyle.semiBold14
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    InkWell(
                      onTap: () {
                        context.router
                            .push(RedeemScreenRoute(isFromEwallet: true));
                      },
                      child: Text(
                        'E pin >>>',
                        style: AppTextStyle.semiBold20
                            .copyWith(color: AppColors.appColors),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    if (model.graphData.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: const BoxDecoration(color: Colors.green),
                        child: Text(
                          '${model.graphData[model.selectedGraphData].rank}',
                          style: AppTextStyle.semiBold16
                              .copyWith(color: Colors.white),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.giftIcon,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Rewards !!',
                              style: AppTextStyle.semiBold14,
                            ),
                            Text(
                              'Start Refer And Get More Exciting Rewards >',
                              style: AppTextStyle.semiBold12,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.size10, vertical: 15),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.cardBlueService),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                model.rechargeServiceList.length,
                (index) => MirrorServiceButton(
                    title: model.rechargeServiceList[index].title.toString(),
                    assetFile:
                        model.rechargeServiceList[index].imageUrl.toString(),
                    onPress: () {
                      if (model.rechargeServiceList[index].functions != null) {
                        appRouter.pushNamed(model
                            .rechargeServiceList[index].functions
                            .toString());
                        // presenter.recentAppUse(
                        //   userId:
                        //       GlobalSingleton.loginInfo!.data!.id.toString(),
                        //   imageurl:
                        //       model.rechargeServiceList[index].imageUrl,
                        //   path:
                        //       model.rechargeServiceList[index].functions,
                        //   title: model.rechargeServiceList[index].title,
                        // );
                      } else {
                        Fluttertoast.showToast(msg: "Coming Soon");
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
    // RechargeContainer(
    //   title: '',
    //   child: Column(
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.symmetric(
    //             horizontal: AppSizes.size10, vertical: 15),
    //         decoration: const BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage(AppAssets.cardBlue), fit: BoxFit.fill)),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   AppConstString.walletBalance.tr(),
    //                   style: AppTextStyle.semiBold16,
    //                 ),
    //                 const SizedBox(
    //                   height: AppSizes.size6,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text(
    //                       '${AppConstString.rupeesSymbol} ${GlobalSingleton.walletBalance}',
    //                       style: AppTextStyle.bold20
    //                           .copyWith(color: AppColors.secoundColors),
    //                     ),
    //                     const SizedBox(
    //                       width: AppSizes.size10,
    //                     ),
    //                     InkWell(
    //                         onTap: () {
    //                           context.router.pushAndPopUntil(
    //                             MainHomeScreenRoute(isFromSignup: false),
    //                             predicate: (route) => false,
    //                           );
    //                         },
    //                         child: const Icon(
    //                           Icons.refresh,
    //                           color: AppColors.secoundColors,
    //                         )),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   AppConstString.cashbackPoint.tr(),
    //                   style: AppTextStyle.semiBold16,
    //                 ),
    //                 const SizedBox(
    //                   height: AppSizes.size6,
    //                 ),
    //                 Text(
    //                   '${AppConstString.rupeesSymbol} ${GlobalSingleton.cashbackWallet}',
    //                   style: AppTextStyle.bold20
    //                       .copyWith(color: AppColors.secoundColors),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       const Divider(),
    //       Container(
    //         padding: const EdgeInsets.symmetric(
    //             horizontal: AppSizes.size10, vertical: 15),
    //         decoration: const BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage(AppAssets.cardBlueService),
    //                 fit: BoxFit.fill)),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: List.generate(
    //             model.rechargeServiceList.length,
    //             (index) => MirrorServiceButton(
    //                 title: model.rechargeServiceList[index].title.toString(),
    //                 assetFile:
    //                     model.rechargeServiceList[index].imageUrl.toString(),
    //                 onPress: () {
    //                   if (model.rechargeServiceList[index].functions != null) {
    //                     appRouter.pushNamed(model
    //                         .rechargeServiceList[index].functions
    //                         .toString());
    //                     // presenter.recentAppUse(
    //                     //   userId:
    //                     //       GlobalSingleton.loginInfo!.data!.id.toString(),
    //                     //   imageurl:
    //                     //       model.rechargeServiceList[index].imageUrl,
    //                     //   path:
    //                     //       model.rechargeServiceList[index].functions,
    //                     //   title: model.rechargeServiceList[index].title,
    //                     // );
    //                   } else {
    //                     Fluttertoast.showToast(msg: "Coming Soon");
    //                   }
    //                 }),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  String formatAmount(String amount) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(double.parse(amount));
  }

  Widget servicesIconDrawerWidget({
    required String? title,
    required String? imageurl,
    required Function()? onPress,
    required List<dynamic>? data,
  }) {
    return InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          SizedBox(
            width: 80,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imageurl!,
                  width: 45,
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    title!,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 79, 78, 78)),
                  ),
                )
              ],
            ),
          ),

          // else
          //   const SizedBox.shrink()
        ],
      ),
    );
  }

  final List mirrorConnectList = [
    {
      "title": "Ticket",
      "imageUrl": AppAssets.todayMessage,
      "function": () {
        appRouter.push(const FeedbackScreenRoute());
      },
    },
    {
      "title": "WhatsApp",
      "imageUrl": AppAssets.whatsapp,
      "function": () {
        const number = AppConstString.supportNumber;
        CommonMethod.whatsapp(mobileNumber: number);
      },
    },
    {
      "title": "Telegram",
      "imageUrl": AppAssets.teleg,
      "function": () {
        launch('https://t.me/mirrorinfotech');
      },
    },
    // {
    //   "title": "Gmail",
    //   "imageUrl": AppAssets.gmail,
    //   "function": () {
    //     launch("mailto:support@mirrorinfo.in");
    //   },
    // },
    {
      "title": "Call",
      "imageUrl": AppAssets.call,
      "function": () {
        CommonMethod.call(number: AppConstString.supportNumber);
      },
    },
  ];

  Widget rankTabDesign() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          UserCountContainer(
            color: const Color(0xFFD9D9D9),
            isSelectedTab: model.tabelName == 'SILVER' ? true : false,
            text: model.silverDetailsResponse.totalCount == null
                ? 'Silver (0)'
                : 'Silver (${model.silverDetailsResponse.totalCount!.first.totalRank})',
            onTap: () {
              model.tabelName = 'SILVER';
              // selectedRank = 0;
              // model.dataMap = {
              //   "Achieve Business":
              //       double.parse(model.graphData[0].receivedIncome ?? "0"),
              //   "Remaining Business ": double.parse(
              //           model.graphData[0].rankAchievverAmount ?? "0") -
              //       double.parse(model.graphData[0].receivedIncome ?? "0"),
              // };
              setState(() {});
            },
            usercountgradient: const LinearGradient(colors: [
              Color(0xFFD9D9D9),
              Color(0xFF6D6D6D),
            ]),
            image: 'silver.png',
          ),
          const SizedBox(
            width: 5,
          ),
          UserCountContainer(
            color: AppColors.secoundColors,
            text: model.silverDetailsResponse.totalCount == null
                ? 'Gold (0)'
                : 'Gold (${model.silverDetailsResponse.totalCount![1].totalRank})',
            isSelectedTab: model.tabelName == 'GOLD' ? true : false,
            onTap: () {
              model.tabelName = 'GOLD';
              // selectedRank = 1;
              // model.dataMap = {
              //   "Achieve Business":
              //       double.parse(model.graphData[1].receivedIncome ?? "0"),
              //   "Remaining Business ": double.parse(
              //           model.graphData[0].rankAchievverAmount ?? "0") -
              //       double.parse(model.graphData[0].receivedIncome ?? "0"),
              // };
              // BlocProvider.of<HomeCubit>(context)
              //     .getTotalSilverDetails(apiName: 'gold');

              setState(() {});
            },
            usercountgradient: const LinearGradient(colors: [
              Color(0xFFFEE0A4),
              Color(0xFFDCB15E),
              Color(0xFFB57B0C)
            ]),
            image: 'gold.png',
          ),
          const SizedBox(
            width: 5,
          ),
          UserCountContainer(
            color: AppColors.appColors,
            // text: 'Diamond (1600)',
            text: model.silverDetailsResponse.totalCount == null
                ? 'Platinum (0)'
                : 'Platinum (${model.silverDetailsResponse.totalCount![2].totalRank})',
            isSelectedTab: model.tabelName == 'Platinum' ? true : false,
            onTap: () {
              model.tabelName = 'Platinum';
              // selectedRank = 2;
              // model.dataMap = {
              //   "Achieve Business":
              //       double.parse(model.graphData[2].receivedIncome ?? "0"),
              //   "Remaining Business ": double.parse(
              //           model.graphData[0].rankAchievverAmount ?? "0") -
              //       double.parse(model.graphData[0].receivedIncome ?? "0"),
              // };
              setState(() {});
            },
            usercountgradient: const LinearGradient(
                colors: [Color(0xFFFFE2C8), Color(0xFFFD7900)]),
            image: 'Diamond.png',
          ),
        ],
      ),
    );
  }
}

class RechargeContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  const RechargeContainer(
      {super.key,
      this.onTap,
      this.margin,
      this.decoration,
      required this.child,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      margin:
          margin ?? const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 4.0),
      decoration: decoration ?? CommonStyleDecoration.serviceBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == ''
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 14, left: 10, top: 10),
                      child: Text(
                        title,
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .4,
                            color: AppColors.blackColor),
                      ),
                    ),
                    if (onTap != null)
                      InkWell(
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 14, left: 10, top: 10),
                          child: Text(
                            AppConstString.viewAll.tr(),
                            textScaleFactor: 1.0,
                            style: AppTextStyle.regular14
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                  ],
                ),
          child,
        ],
      ),
    );
  }
}

class MirrorServiceButton extends StatelessWidget {
  final String assetFile;
  final String title;
  final Function() onPress;
  const MirrorServiceButton(
      {super.key,
      required this.assetFile,
      required this.title,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Image.asset(
              'assets/icons/recharge_pay/$assetFile',
              width: 40,
              height: 40,
              // color: primaryColor,
            ),
          ),
          Text(
            title,
            textScaleFactor: 1.0,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, letterSpacing: .4),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales, this.color);
  final String year;
  final double sales;
  final Color color;
}

class ServicesIconWidget extends StatelessWidget {
  final String? title;
  final String? imageurl;
  final Function()? onPress;
  final Function()? extraFunction;
  final List<dynamic>? data;
  final bool? imageFullPath;
  // ignore: use_key_in_widget_constructors
  const ServicesIconWidget({
    required this.title,
    required this.imageurl,
    this.onPress,
    this.imageFullPath,
    required this.data,
    this.extraFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          // onPress,
          extraFunction != null
              ? () {
                  if (onPress != null) {
                    onPress!();
                  }
                  if (extraFunction != null) {
                    extraFunction!();
                  }
                }
              : onPress,
      child: Stack(
        children: [
          SizedBox(
            width: imageFullPath == true ? 80 : 80,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    imageFullPath == true
                        ? imageurl!
                        : 'assets/icons/recharge_pay/$imageurl',
                    width: 51,
                    height: 50,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 45,
                  child: Text(
                    title!,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 79, 78, 78)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollView extends StatefulWidget {
  const ScrollView({super.key});

  @override
  State<ScrollView> createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView> {
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
                height: 500.0, width: double.infinity, child: Card()),
            const SizedBox(
                height: 500.0, width: double.infinity, child: Card()),
            const SizedBox(
                height: 300.0, width: double.infinity, child: Card()),
            // destination
            Card(
              key: dataKey,
              child: const Text("data\n\n\n\n\n\ndata"),
            )
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
        onTap: () => Scrollable.ensureVisible(dataKey.currentContext!),
        text: "Scroll to data",
      ),
    );
  }
}
