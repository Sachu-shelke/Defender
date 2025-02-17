import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  String _linkMessage = '';
  int totalReferCount = 0;
  int dailyCount = 0;
  @override
  void initState() {
    getLinkData();
    getTeamDetails(
        context: context,
        planID: '0',
        userId: GlobalSingleton.loginInfo!.data!.id.toString());
    _initPrefs();
    super.initState();
  }

  Future<void> _initPrefs() async {
    _resetDailyCountIfNeeded();
    _loadDailyCount();
  }

  Future<void> _loadDailyCount() async {
    setState(() {
      dailyCount = StorageManager.getIntValue('dailyReferCount') ?? 0;
    });
  }

  Future<void> _incrementDailyCount() async {
    int newCount = (dailyCount + 1);
    StorageManager.setIntValue(key: 'dailyReferCount', value: newCount);
    setState(() {
      dailyCount = newCount;
    });
  }

  void _resetDailyCountIfNeeded() {
    if (StorageManager.getStringValue('dailylastDate') != null) {
      DateTime now = DateTime.now();
      DateTime lastStoredDate =
          DateTime.parse(StorageManager.getStringValue('dailylastDate') ?? '');
      if (lastStoredDate.day != now.day ||
          lastStoredDate.month != now.month ||
          lastStoredDate.year != now.year) {
        StorageManager.setIntValue(key: 'dailyReferCount', value: 0);
        StorageManager.setStringValue(
            key: 'dailylastDate', value: DateFormat('yyyy-MM-dd').format(now));
      }
    } else {
      DateTime now = DateTime.now();
      StorageManager.setIntValue(key: 'dailyReferCount', value: 0);
      StorageManager.setStringValue(
          key: 'dailylastDate', value: DateFormat('yyyy-MM-dd').format(now));
    }
  }

  getLinkData() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: ApiPath.dynamicLink,
      link: Uri.https('invite friend', 'refer',
          {"refercode": GlobalSingleton.loginInfo!.data!.mobile.toString()}),
      androidParameters: androidParameters(),
      iosParameters: iosParameters(),
    );
    // _shareInviteLink(parameters, GlobalSingleton.loginInfo!.data!.mobile.toString(), name);

    Uri url;
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    url = shortLink.shortUrl;
    _linkMessage = url.toString();
    setState(() {});
  }

  Future<void> getTeamDetails(
      {required String userId,
      required String planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + ApiPath.teamDetails,
        data: {'user_id': userId, 'plan_id': planID},
        context: context);

    if (response != null && response['status'] == 200) {
      Leveldata lev = TeamDetailsModel.fromJson(response).leveldata!.first;
      totalReferCount = (lev.totalInactive ?? 0) + (lev.totalInactive ?? 0);
    }
    setState(() {});
  }

  static AndroidParameters androidParameters() {
    return const AndroidParameters(
      packageName: 'com.mirrorinfo.business',
    );
  }

  static IOSParameters iosParameters() {
    return const IOSParameters(
      bundleId: 'com.mirrorinfo.business',
      appStoreId: '1596096696',
    );
  }

  @override
  Widget build(BuildContext context) {
    //  print(_linkMessage.toString());
    return Scaffold(
      backgroundColor: const Color(0xFFFAECE0),
      appBar: const CustomAppBar(title: 'Refer & Earn'),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFF99840),
            Color(0xFFFAECE0),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Invite Friends to join and make money together',
                    style: AppTextStyle.semiBold22
                        .copyWith(color: AppColors.whiteColor),
                  )),
                  Image.asset(
                    AppAssets.referAFriend,
                    height: 200,
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'My Refer',
                  style: AppTextStyle.semiBold16
                      .copyWith(color: AppColors.darkgreyColor),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffFADBBF),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 2.0, color: Colors.orange.shade700),
                              right: BorderSide(
                                  width: 2.0, color: Colors.orange.shade700),
                              bottom: BorderSide(
                                  width: 2.0, color: Colors.orange.shade700),
                              top: BorderSide(
                                  width: 2.0, color: Colors.orange.shade700)),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(totalReferCount.toString()),
                            const Text('Total Refer'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffFADBBF),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(dailyCount.toString()),
                            const Text('Todays Refer'),
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
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffFADBBF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Send the invitation link to you friends, they can register through this link, and you will receive rewards.',
                        style: AppTextStyle.semiBold14
                            .copyWith(color: const Color(0xffF5334F)),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invite Link',
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.greyColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _linkMessage.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.semiBold16,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: _linkMessage.toString()));
                                  // _incrementDailyCount();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff31C3FF)),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Copy',
                                        style: AppTextStyle.semiBold14.copyWith(
                                            color: AppColors.whiteColor),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Number',
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.greyColor),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  GlobalSingleton.loginInfo!.data!.mobile
                                      .toString(),
                                  style: AppTextStyle.semiBold16,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: GlobalSingleton
                                          .loginInfo!.data!.mobile
                                          .toString()));
                                  // _incrementDailyCount();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff31C3FF)),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Copy',
                                        style: AppTextStyle.semiBold14.copyWith(
                                            color: AppColors.whiteColor),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // bbpsData(
                  //     context: context,
                  //     userId: GlobalSingleton.loginInfo!.data!.id.toString());
                  CommonMethod()
                      .getUserLog(action: 'Business_Refer_link', id: 9);
                  CommonMethod.referLink(
                      referCode:
                          GlobalSingleton.loginInfo!.data!.mobile.toString(),
                      name:
                          "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
                  _incrementDailyCount();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff31C3FF)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.screen_share_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Refer',
                        style: AppTextStyle.semiBold18
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> bbpsData(
      {required String userId, required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: '${ApiPath.apiEndPoint}/bill_payment/billdesk-request',
        data: {'user_id': userId, 'amount': 100},
        context: context);

    if (response != null && response['status'] == 200) {
      log(response.toString());
    }
    setState(() {});
  }
}
