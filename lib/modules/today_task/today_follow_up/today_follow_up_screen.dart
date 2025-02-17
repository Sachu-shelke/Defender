// ignore_for_file: use_build_context_synchronously

import 'dart:math';

// import 'package:call_log/call_log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
import 'package:defenders/modules/today_task/today_follow_up/team_dashboard_screen.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_model.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_presenter.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_view.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_prime_direct_screen.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
// import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class TodayFollowUpScreen extends StatefulWidget {
  const TodayFollowUpScreen({super.key});

  @override
  State<TodayFollowUpScreen> createState() => _TodayFollowUpScreenState();
}

class _TodayFollowUpScreenState extends State<TodayFollowUpScreen>
    with WidgetsBindingObserver
    implements TodayFollowUpView {
  TodayFollowUpPresenter presenter = BaasicTodayFollowUpPresenter();
  late TodayFollowUpModel model;
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int selectedIndex = 0;
  // List<CallLogEntry>? reciveentries;
  // List<CallLogEntry>? sendentries;
  Circle progress = Circle();
  int selectedLang = 0;

  List lanList = [
    {
      'name': 'English',
      'title':
          "Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.",
    },
    {
      'name': 'Hindi',
      'title':
          "मिरर आपके प्राइवेसी का सम्मान करता है। इसलिए हम आपकी कॉल हिस्ट्री एकत्र या संग्रहीत नहीं करते हैं। यह सुविधा केवल आपके लीड को याद दिलाने में मदद करती है।.",
    },
    {
      'name': 'Gujrati',
      'title':
          "મિરર તમારી પ્રીવાસી નો આદર કરે છે. તેથી અમે તમારો કોલ હિસ્ટોરી એકત્રિત અથવા સંગ્રહિત કરતા નથી. આ સુવિધા ફક્ત તમારા લીડ્સને યાદ કરાવવામાં મદદ કરે છે.",
    },
    {
      'name': 'Marathi',
      'title':
          "मिरर तुमच्या प्रायव्हसीचा आदर करतो. म्हणून आम्ही कॉन्टॅक्ट हिस्ट्री कल्लेक्ट व स्टोर करत नाही. हे वैशिष्ट्य फक्त तुमच्या लीड्सची आठवण करून देण्यात मदत करते.",
    },
  ];

  String marathi = "";

  int dailyCount = 0;
  @override
  void initState() {
    super.initState();
    getPermision();
    presenter.getTotalCount();
    presenter.getTeamDetails(
        userID: GlobalSingleton.loginInfo!.data!.id.toString(),
        level: '1',
        context: context,
        primeId: '0',
        page: page);
    presenter.getMsgContent(context: context);

    _scrollController.addListener(_scrollListener);
    presenter.updateView = this;
    // _getCallLogs();
    // _getSendCall();
    _initPrefs();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   if (state == AppLifecycleState.resumed) {
  //     getTimeFunction();
  //     print('resumed');
  //   } else if (state == AppLifecycleState.paused) {
  //     print('paused');
  //     timeStoreFunction();
  //   }
  // }

  timeStoreFunction() async {
    DateTime youtubeStoreTime = DateTime.fromMillisecondsSinceEpoch(
        StorageManager.getIntValue('callStartTimeShowTime') ?? 0);
    int youtubesubscribedDialog =
        DateTime.now().difference(youtubeStoreTime).inSeconds;

    if (youtubesubscribedDialog > 5) {
      StorageManager.setIntValue(
          key: 'callStartTimeShowTime',
          value: DateTime.now().millisecondsSinceEpoch);
      // youtubeDialog();
      CommonMethod().getUserLog(action: 'Call', id: 4);

      _incrementDailyCount();
    }
    StorageManager.clearKey('callStartTime');
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    StorageManager.setIntValue(key: 'callStartTime', value: timestamp);
  }

  getTimeFunction() {
    StorageManager.setIntValue(
        key: 'callStartTime', value: DateTime.now().millisecondsSinceEpoch);
  }

  getPermision() async {
    await Permission.sms.request();
  }

  Future<void> _initPrefs() async {
    _resetDailyCountIfNeeded();
    _loadDailyCount();
  }

  void _resetDailyCountIfNeeded() {
    if (StorageManager.getStringValue('lastDate') != null) {
      DateTime now = DateTime.now();
      DateTime lastStoredDate =
          DateTime.parse(StorageManager.getStringValue('lastDate') ?? '');
      if (lastStoredDate.day != now.day ||
          lastStoredDate.month != now.month ||
          lastStoredDate.year != now.year) {
        StorageManager.setIntValue(key: 'dailyCount', value: 0);
        StorageManager.setStringValue(
            key: 'lastDate', value: DateFormat('yyyy-MM-dd').format(now));
      }
    } else {
      DateTime now = DateTime.now();
      StorageManager.setIntValue(key: 'dailyCount', value: 0);
      StorageManager.setStringValue(
          key: 'lastDate', value: DateFormat('yyyy-MM-dd').format(now));
    }
  }

  Future<void> _loadDailyCount() async {
    setState(() {
      dailyCount = StorageManager.getIntValue('dailyCount') ?? 0;
    });
  }

  Future<void> _incrementDailyCount() async {
    int newCount = (dailyCount + 1);
    StorageManager.setIntValue(key: 'dailyCount', value: newCount);
    setState(() {
      dailyCount = newCount;
    });
  }

  @override
  void refreshModel(TodayFollowUpModel sendMoneyModel) {
    model = sendMoneyModel;
    if (mounted) {
      setState(() {});
    }
  }

  _scrollListener() {
    if ((_scrollController.position.maxScrollExtent / 2) ==
        (_scrollController.offset / 2)) {
      // if (model.lastPageIndex > page) {
      setState(() {
        page++;
      });
      presenter.getTeamDetails(
          page: page,
          level: '1',
          primeId: '0',
          // context: context,
          userID: GlobalSingleton.loginInfo!.data!.id.toString());
    }
  }

  // _getCallLogs() async {
  //   DateTime now = DateTime.now();
  //   DateTime startOfDay = DateTime(now.year, now.month, now.day);
  //   DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
  //   Iterable<CallLogEntry> entries = await CallLog.query(
  //     dateFrom: startOfDay.millisecondsSinceEpoch,
  //     dateTo: endOfDay.millisecondsSinceEpoch,
  //     type: CallType.incoming,
  //   );

  //   reciveentries = entries.toList();
  //   if (reciveentries != null &&
  //       reciveentries!.isNotEmpty &&
  //       StorageManager.getBoolValue('isCallLogHide') != true) {
  //     getMsgContent(context: context);
  //   }

  //   setState(() {});
  // }

  // Future<void> getMsgContent({
  //   required BuildContext context,
  // }) async {
  //   List callList = [];

  //   for (var i = 0; i < reciveentries!.length; i++) {
  //     callList.add({
  //       'mobile': reciveentries![i].number,
  //       'name': reciveentries![i].name,
  //       'type': 'incoming',
  //     });
  //   }

  //   Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
  //       url: ApiPath.apiEndPoint + ApiPath.uploadUserContact,
  //       data: {
  //         'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
  //         'dataList': callList
  //       });
  //   if (response != null && response['status'] == 200) {}
  //   setState(() {});
  // }

  // _getSendCall() async {
  //   DateTime now = DateTime.now();
  //   DateTime startOfDay = DateTime(now.year, now.month, now.day);
  //   DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
  //   Iterable<CallLogEntry> entries = await CallLog.query(
  //     dateFrom: startOfDay.millisecondsSinceEpoch,
  //     dateTo: endOfDay.millisecondsSinceEpoch,
  //     type: CallType.outgoing,
  //   );
  //   sendentries = entries.toList();

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Today Call'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Banners(
          localModel: [AppAssets.todayCallBanner],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.greyColor)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.phoneCallback,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '10',
                          // '${reciveentries != null ? reciveentries!.length : 0}',
                          style: AppTextStyle.semiBold20,
                        ),
                      ],
                    ),
                    const Text('Today target Call'),
                  ],
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

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const TodayFollowUpScreen())).then((value) {
                  //   _getSendCall();
                  // });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.greyColor)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.phonecall,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            max(10 - dailyCount, 0).toString(),
                            style: AppTextStyle.semiBold20
                                .copyWith(color: AppColors.secoundColors),
                          ),
                          const Text('/'),
                          Text(
                            dailyCount.toString(),
                            style: AppTextStyle.semiBold20
                                .copyWith(color: AppColors.appColors),
                          ),
                        ],
                      ),
                      const Text('Today Done Call'),
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
          height: 10,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Today Call',
                style: AppTextStyle.semiBold16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Team Level ${model.level}',
                style: AppTextStyle.semiBold16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        // if (reciveentries != null)
        Expanded(
          child: ListView.builder(
            itemCount: model.teamDetailsdata.length,
            controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // CallLogEntry log = reciveentries![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPortfolioScreen(
                        userInfo: model.teamDetailsdata[index],
                      ),
                    ),
                  );
                  // TeamDashboardScreen
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appColors),
                    ),
                    child: Row(
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
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${model.teamDetailsdata[index].name.toString()}',
                                maxLines: 1,
                              ),
                              Text(
                                  'Mobile Number : ${model.teamDetailsdata[index].mobile.toString()}'),
                              Text(
                                  'Date of Join : ${model.teamDetailsdata[index].joiningDate.toString()}'),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        InkWell(
                          onTap: () {
                            // CommonMethod().getUserLog(action: 'Call', id: 4);
                            if (model.teamDetailsdata[index].mobile != null) {
                              CommonMethod.whatsapp(
                                  mobileNumber: model
                                      .teamDetailsdata[index].mobile
                                      .toString());
                            }
                          },
                          child: Image.asset(
                            AppAssets.whatsapp,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () async {
                            if (model.teamDetailsdata[index].mobile != null) {
                              // getTimeFunction();
                              _incrementDailyCount();
                              CommonMethod().getUserLog(action: 'Call', id: 4);
                              await FlutterPhoneDirectCaller.callNumber(model
                                  .teamDetailsdata[index].mobile
                                  .toString());
                            }
                            setState(() {});
                          },
                          child: Image.asset(
                            AppAssets.phoneIcon,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    )
                    // ListTile(
                    //   title: Text('Name: ${log.name ?? ''}'),
                    //   subtitle: Text('Mobile Number :- ${log.number ?? ''}'),
                    // ),
                    ),
              );
            },
          ),
        )
      ]),
    );
  }

  dialogData() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setstate) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Declaimer: Call_Logs_Permission',
                    style: AppTextStyle.semiBold20.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                    child: SingleChildScrollView(
                      child: Row(
                        children: List.generate(
                            4,
                            (index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: InkWell(
                                        onTap: () {
                                          selectedLang = index;
                                          setstate(() {});
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              lanList[index]['name'],
                                              style: AppTextStyle.semiBold14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (selectedLang == index)
                                      Container(
                                        height: 2,
                                        width: 80,
                                        color: AppColors.secoundColors,
                                      )
                                  ],
                                )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    lanList[selectedLang]['title'],
                    // 'Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.',
                    textAlign: TextAlign.left,
                    style: AppTextStyle.regular16,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 40),
                        decoration: BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'OK',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
