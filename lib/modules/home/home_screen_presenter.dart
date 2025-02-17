// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/banner_model/banner_model.dart';
import 'package:defenders/model/company/user_graph_model.dart';
import 'package:defenders/model/graphics/get_graphics_main_model.dart';
import 'package:defenders/model/home_model/rank_details_count_model.dart';
import 'package:defenders/model/notification/notification_model.dart';
import 'package:defenders/model/profile/profile_model.dart';
import 'package:defenders/model/recent_screen_model.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/modules/home/home_screen_model.dart';
import 'package:defenders/modules/home/home_screen_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/model/graphics/get_graphics_model.dart' as ge;
import 'package:url_launcher/url_launcher.dart';

class HomeScreenPresenter {
  Future<void> getWalletBalance({
    required String userID,
  }) async {}
  Future<void> getProfile({
    required BuildContext context,
  }) async {}
  Future<void> getTotalCount({
    BuildContext? context,
  }) async {}
  Future<void> getCompanyGraph({required BuildContext context}) async {}
  Future<void> getBanner() async {}
  Future<void> getRankWiseTeam() async {}
  Future<void> registerToken({required String token}) async {}
  Future<void> getGraphics({required BuildContext context}) async {}

  Future<void> updateLike({
    required String id,
    required String action,
  }) async {}
  Future<void> getNotification({
    required BuildContext context,
  }) async {}
  Future<void> getGraphicsData(
      {required int page,
      BuildContext? context,
      required String catId}) async {}
  set updateView(HomeScreenView addMoneyView) {}
}

class BasicHomeScreenPresenter implements HomeScreenPresenter {
  late HomeScreenView view;
  late HomeScreenModel model;
  BasicHomeScreenPresenter() {
    model = HomeScreenModel(
        todayData: TeamDetailsInfoModel(),
        todayIncome: 0,
        totalEarning: 0,
        notificationdata: [],
        categoriesIdList: idList,
        tabindex: 0,
        silverDetailsResponse: GetRankDetailsModel(),
        graphData: [],
        graphicsdata: [],
        mirrorConnectList: mirrorConnectList,
        selectedGraphData: 0,
        rechargeServiceList: [
          RecentAppUseData(
              title: "Add Money",
              imageUrl: "addmoney.png",
              functions: '/add_moeny_screen'),
          RecentAppUseData(
              title: "Send Money",
              imageUrl: "sendmoney.png",
              functions: '/send_money_screen/false'),
          RecentAppUseData(
              title: "PassBook",
              imageUrl: "passbook.png",
              functions: '/passbook_page'),
        ],
        tabelName: 'SILVER',
        graphicsList: ge.GetGraphicsCategoryModel(),
        todayList: [
          {'image': AppAssets.todayCall, 'name': "Today's Call"},
          {'image': AppAssets.todaySearch, 'name': "Today's Refer"},
          {'image': AppAssets.todayRefer, 'name': "Today's Follow-UP"},
          {'image': AppAssets.todayMessage, 'name': "WatsApp MSG"},
          {'image': AppAssets.todayMobile, 'name': "Social Media Post"},
          {'image': AppAssets.todayPerson, 'name': "Today's GM Post"},
        ],
        leadsList: []);
    view = HomeScreenView();
  }

  List idList = [
    {'id': '12', 'Name': 'Welcome'},
    {'id': '11', 'Name': 'Motivation'},
    {'id': '10', 'Name': 'Celebration'},
    {'id': '9', 'Name': 'Achievement'},
    {'id': '8', 'Name': 'Daily Wishesh'},
    {'id': '7', 'Name': 'Festival'},
    {'id': '6', 'Name': 'Wedding'},
    {'id': '5', 'Name': 'Anniversary'},
    {'id': '4', 'Name': 'Birthday'},
    {'id': '3', 'Name': 'Earning'},
    // {'id': '2', 'Name': 'Payout'},
    {'id': '1', 'Name': 'Marketing'},
    {'id': '12', 'Name': 'Welcome'},
    {'id': '11', 'Name': 'Motivation'},
    {'id': '10', 'Name': 'Celebration'},
    {'id': '9', 'Name': 'Achievement'},
    {'id': '8', 'Name': 'Daily Wishesh'},
    {'id': '7', 'Name': 'Festival'},
    {'id': '6', 'Name': 'Wedding'},
    {'id': '5', 'Name': 'Anniversary'},
    {'id': '4', 'Name': 'Birthday'},
    {'id': '3', 'Name': 'Earning'},
    // {'id': '2', 'Name': 'Payout'},
    {'id': '1', 'Name': 'Marketing'},
    {'id': '12', 'Name': 'Welcome'},
    {'id': '11', 'Name': 'Motivation'},
    {'id': '10', 'Name': 'Celebration'},
    {'id': '9', 'Name': 'Achievement'},
    {'id': '8', 'Name': 'Daily Wishesh'},
    {'id': '7', 'Name': 'Festival'},
    {'id': '6', 'Name': 'Wedding'},
    {'id': '5', 'Name': 'Anniversary'},
    {'id': '4', 'Name': 'Birthday'},
    {'id': '3', 'Name': 'Earning'},
    // {'id': '2', 'Name': 'Payout'},
    {'id': '1', 'Name': 'Marketing'},
    {'id': '12', 'Name': 'Welcome'},
    {'id': '11', 'Name': 'Motivation'},
    {'id': '10', 'Name': 'Celebration'},
    {'id': '9', 'Name': 'Achievement'},
    {'id': '8', 'Name': 'Daily Wishesh'},
    {'id': '7', 'Name': 'Festival'},
    {'id': '6', 'Name': 'Wedding'},
    {'id': '5', 'Name': 'Anniversary'},
    {'id': '4', 'Name': 'Birthday'},
    {'id': '3', 'Name': 'Earning'},
    // {'id': '2', 'Name': 'Payout'},
    {'id': '1', 'Name': 'Marketing'},
  ];

  final List mirrorConnectList = [
    // {
    //   "title": "Ticket",
    //   "image_url": AppAssets.todayMessage,
    //   "functions": () {
    //     appRouter.push(const FeedbackScreenRoute());
    //   },
    // },
    {
      "title": "WhatsApp",
      "image_url": AppAssets.whatsapp,
      "functions": () {
        const number = AppConstString.supportNumber;
        CommonMethod.whatsapp(mobileNumber: number);
      },
    },
    {
      "title": "Telegram",
      "image_url": AppAssets.teleg,
      "functions": () {
        launch('https://t.me/Mirror_Infotech_official');
      },
    },
    {
      "title": "Gmail",
      "image_url": AppAssets.gmail,
      "functions": () {
        launch("mailto:support@mirrorinfo.in");
      },
    },
    {
      "title": "Call",
      "image_url": AppAssets.call,
      "functions": () {
        CommonMethod.call(number: AppConstString.supportNumber);
      },
    },
  ];

  //   @override
  // Future<void> getProfile({
  //   required BuildContext context,
  // }) async {
  //   Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
  //       url: ApiPath.apiEndPoint + ApiPath.getProfile,
  //       data: {
  //         'id': GlobalSingleton.loginInfo!.data!.id.toString(),
  //       },
  //       context: context);

  //   if (response != null && response['status'] == 200) {
  //     // model.data = ProfileScreenModel.fromJson(response).data!.first;
  //   }
  //   view.refreshModel(model);
  // }

  @override
  Future<void> getCompanyGraph({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.companyGraph,
        data: {'user_id': GlobalSingleton.loginInfo!.data!.id.toString()});
    // print(response.toString());
    if (response != null && response['status'] == 200) {
      model.graphData = CompanyGraphModel.fromJson(response).data!;

      // CompanyGraphData removedElement = model.graphData
      //     .removeAt(6); // Since list index starts from 0, index 8 is 7

      // // Step 2: Insert the removed element at index 2
      // model.graphData.insert(1, removedElement);

      for (var i = model.graphData.length - 1; i >= 0; i--) {
        if (
            // model.graphData[i].category !=
            model.graphData[i].rankAchieverCategory != "No Rank"
            // model.graphData[i].targetAchievverAmount
            ) {
          GlobalSingleton.rank = model.graphData[i].category.toString();
          model.selectedGraphData = i + 1;
          if (model.selectedGraphData > model.graphData.length) {
            model.selectedGraphData = model.graphData.length;
          }

          model.dataMap = {
            "Achieve Business": double.parse(
                model.graphData[model.selectedGraphData].receivedIncome ?? "0"),
            "Remaining Business ": double.parse(model
                        .graphData[model.selectedGraphData]
                        .rankAchievverAmount ??
                    "0") -
                double.parse(
                    model.graphData[model.selectedGraphData].receivedIncome ??
                        "0"),
          };
          break;
        }
      }
      if (model.dataMap == null) {
        GlobalSingleton.rank = "Distributor";
      }
      model.dataMap ??= {
        "Achieve Business": double.parse(
            model.graphData[model.selectedGraphData].receivedIncome ?? "0"),
        "Remaining Business ": double.parse(
                model.graphData[model.selectedGraphData].rankAchievverAmount ??
                    "0") -
            double.parse(
                model.graphData[model.selectedGraphData].receivedIncome ?? "0"),
      };
    }
    view.refreshModel(model);
  }

  @override
  Future<void> updateLike({
    required String id,
    required String action,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.updateLike,
        data: {
          'id': id,
          'action': action,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        });
    if (response != null && response['status'] == 200) {
      view.refreshModel(model);
    }
  }

  @override
  Future<void> getProfile({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getProfile,
      data: {
        'id': GlobalSingleton.loginInfo!.data!.id.toString(),
      },
    );

    if (response != null && response['status'] == 200) {
      ProfileData mod = ProfileScreenModel.fromJson(response).data!.first;

      GlobalSingleton.hybridPrime = mod.flagsObject!.hybridPrime;
      GlobalSingleton.boosterPrime = mod.flagsObject!.boosterPrime;
      GlobalSingleton.prime = mod.flagsObject!.prime;
      GlobalSingleton.primeB = mod.flagsObject!.primeB;
      GlobalSingleton.profilePic = mod.profilePic;
      StorageManager.setIntValue(key: 'isPrime', value: mod.isPrime ?? 0);
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getGraphicsData(
      {required int page, BuildContext? context, required String catId}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getGraphics,
        data: {
          'page': page,
          'category_id': catId,
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
        },
        context: context);
    // print(response.toString());
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        model.graphicsdata =
            GetGraphicsMainModel.fromJson(response).data!.data!;
      } else {
        model.graphicsdata
            .addAll(GetGraphicsMainModel.fromJson(response).data!.data!);
      }
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getWalletBalance({
    required String userID,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getWalletBalance,
      data: {
        'user_id': userID,
      },
    );

    if (response != null && response['status'] == 200) {
      GlobalSingleton.isPortfolioShoe = response['is_portfolio'].toString();
      GlobalSingleton.cashbackWallet = double.parse(
          double.parse(response['cashbackBalance'].toString())
              .toStringAsFixed(2));
      GlobalSingleton.walletBalance = double.parse(
          double.parse(response['walletBalance'].toString())
              .toStringAsFixed(2));
      GlobalSingleton.primeWallet = double.parse(
          double.parse(response['primeBalance'].toString()).toStringAsFixed(2));
      GlobalSingleton.affiliateWallet = double.parse(
          double.parse(response['affiliateBalance'].toString())
              .toStringAsFixed(2));
      GlobalSingleton.epinWalletBalance = double.parse(
          double.parse(response['epinWalletBalance'].toString())
              .toStringAsFixed(2));
      // GlobalSingleton.rank = response['rank'].toString();

      model.todayIncome = response['today_income'];
      model.totalEarning = response['total_earning'];
      // voucher
      // GlobalSingleton.vouchers = response['voucher'];
      view.refreshModel(model);
    }
  }

  @override
  Future<void> registerToken({required String token}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.registerToken,
        data: {
          'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
          "token": token,
          "app_id": "2"
        });
    if (response != null && response['status'] == 200) {}
    view.refreshModel(model);
  }

  @override
  Future<void> getGraphics({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.getGraphicsCategories,
      // data: {'user_id': GlobalSingleton.loginInfo!.data!.id.toString()},
      // context: context
    );

    if (response != null && response['status'] == 200) {
      model.graphicsList = ge.GetGraphicsCategoryModel.fromJson(response);
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getBanner() async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getBanner,
        data: {'categoryId': '8'});
    if (response != null && response['status'] == 200) {
      model.bennerApiList = GetBannerModel.fromJson(response).data;
      GlobalSingleton.bannerList = model.bennerApiList!;
      // convertNetworkToFile();
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getNotification({
    required BuildContext context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.notification,
      // context: context,
      data: {
        'app_id': '2',
        'page': 1,
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
      },
    );

    if (response != null && response['status'] == 200) {
      model.notificationdata = NotificationModel.fromJson(response).data!.data!;
      if (model.notificationdata.isNotEmpty) {
        dialogData(
            crn: context,
            body: model.notificationdata.first.body.toString(),
            title: model.notificationdata.first.title.toString());
      }
    }
    view.refreshModel(model);
  }

  dialogData({
    required String body,
    required String title,
    required BuildContext crn,
  }) {
    return showDialog(
      context: crn,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.notifications),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        title.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   ,
                //   style: const TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.w700),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body.toString(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
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
      },
    );
  }

  @override
  Future<void> getTotalCount({
    BuildContext? context,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.dailyTeamDetails,
      context: context,
      data: {
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
        "type": "Prime",
        'page': 1
      },
    );

    // log(response.toString());
    if (response != null && response['status'] == 200) {
      model.todayData = TeamDetailsInfoModel.fromJson(response);
    }
    view.refreshModel(model);
  }

  @override
  Future<void> getRankWiseTeam() async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.totalRankDistribution,
        data: {'page': 1});
    if (response != null && response['status'] == 200) {
      model.silverDetailsResponse = GetRankDetailsModel.fromJson(response);
    }
    view.refreshModel(model);
  }

  // Future<void> convertNetworkToFile() async {
  //   for (int i = 0; i < model.bennerApiList!.length; i++) {
  //     final http.Response responseData = await http.get(
  //       Uri.parse(
  //         model.bennerApiList![i].img.toString(),
  //       ),
  //     );
  //     Uint8List uint8list = responseData.bodyBytes;
  //     model.bennerApiList![i].img = uint8list.toString();
  //   }

  //   GlobalSingleton.bannerList = model.bennerApiList!;

  //   view.refreshModel(model);
  // }

  @override
  set updateView(HomeScreenView homeScreenView) {
    view = homeScreenView;
    view.refreshModel(model);
  }
}
