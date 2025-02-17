import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/business/business_widget/user_business_details.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TeamPortfolioScreen extends StatefulWidget {
  final TeamDetailsInfoData userInfo;

  const TeamPortfolioScreen({
    super.key,
    required this.userInfo,
  });

  @override
  State<TeamPortfolioScreen> createState() => _TeamPortfolioScreenState();
}

class _TeamPortfolioScreenState extends State<TeamPortfolioScreen> {
  @override
  void initState() {
    super.initState();

    getTeamDetails(
      userId: widget.userInfo.id.toString(),
      context: context,
    );
  }

  List<DashboardIncomeList> filteredincomeList = [
    DashboardIncomeList(
        name: "Total Earnings",
        income: "${AppConstString.rupeesSymbol} 0",
        path: '/Income_Passbook_screen',
        catId: 1,
        image: AppAssets.b1),
    DashboardIncomeList(
        name: "Total Withdraw",
        income: "${AppConstString.rupeesSymbol} 0",
        path: '/Redeem_Screen',
        catId: 1,
        image: AppAssets.b2),
    DashboardIncomeList(
        name: "Total Team",
        catId: 2,
        color: Colors.orange,
        income: "0",
        path: '/Prime_Team_Screen/3',
        image: AppAssets.b3,
        id: '3'),
    DashboardIncomeList(
        name: "Prime B Team",
        catId: 2,
        color: Colors.green,
        image: AppAssets.b4,
        path: '/Prime_Team_Screen/4',
        income: "0",
        id: '4'),
    DashboardIncomeList(
        name: "Booster Team",
        catId: 2,
        color: Colors.black,
        path: '/Prime_Team_Screen/2',
        image: AppAssets.b5,
        income: " 0",
        id: '2'),
    DashboardIncomeList(
        name: "Hybrid Team",
        catId: 2,
        color: Colors.blue,
        path: '/Prime_Team_Screen/1',
        image: AppAssets.b6,
        income: " 0",
        id: '1'),
    DashboardIncomeList(
      name: "Self Reward",
      catId: 1,
      income: " 0",
      image: AppAssets.b7,
    ),
    DashboardIncomeList(
      name: "Repurchase Reward",
      catId: 1,
      image: AppAssets.b8,
      income: " 0",
    ),
    DashboardIncomeList(
        name: "Level Reward", catId: 1, income: " 0", image: AppAssets.b9),
    DashboardIncomeList(
        name: "Upgrade Reward", catId: 1, income: " 0", image: AppAssets.b10),
    DashboardIncomeList(
        name: "Silver Royality", catId: 3, income: " 0", image: AppAssets.b11),
    DashboardIncomeList(
        name: "Gold Royality", catId: 3, income: " 0", image: AppAssets.b12),
    DashboardIncomeList(
        name: "Car Fund", catId: 0, income: " 0", image: AppAssets.b19),
    DashboardIncomeList(
        name: "Diamond Royality", catId: 3, income: " 0", image: AppAssets.b13),
    DashboardIncomeList(
        name: "Double Diamond Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b13),
    DashboardIncomeList(
        name: "Platinum Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b14),
    DashboardIncomeList(
        name: "Ambassdor Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b15),
    DashboardIncomeList(
        name: "House Fund", catId: 0, income: " 0", image: AppAssets.b16),
    DashboardIncomeList(
        name: "Travel Fund", catId: 0, income: " 0", image: AppAssets.b17),
    DashboardIncomeList(
      name: "Award Fund",
      catId: 0,
      image: AppAssets.b18,
      income: " 0",
    ),
  ];

  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.teamDetails,
        data: {'user_id': userId, 'plan_id': planID},
        context: context);

    if (response != null && response['status'] == 200) {
      TeamDetailsModel teamDetails = TeamDetailsModel.fromJson(response);
      filteredincomeList.first.income = AppConstString.rupeesSymbol +
          teamDetails.data!.first.totalEarning.toString();
      filteredincomeList[1].income = AppConstString.rupeesSymbol +
          teamDetails.data!.first.totalWithdrawal.toString();
      filteredincomeList[2].income =
          teamDetails.data!.first.totalMember.toString();
      filteredincomeList[3].income = teamDetails.data!.first.primeB.toString();
      filteredincomeList[4].income = teamDetails.data!.first.booster.toString();
      filteredincomeList[5].income = teamDetails.data!.first.hybrid.toString();
      filteredincomeList[7].income =
          teamDetails.data!.first.totalRepurchaseIncome.toString();
      filteredincomeList[10].income = teamDetails.data!.first.silver.toString();
      filteredincomeList[11].income = teamDetails.data!.first.gold.toString();
      filteredincomeList[12].income =
          teamDetails.data!.first.carFund.toString();
      filteredincomeList[13].income =
          teamDetails.data!.first.diamond.toString();
      filteredincomeList[14].income =
          teamDetails.data!.first.doubleDiamond.toString();
      filteredincomeList[15].income =
          teamDetails.data!.first.platinum.toString();
      filteredincomeList[16].income =
          teamDetails.data!.first.ambassador.toString();
      filteredincomeList[17].income =
          teamDetails.data!.first.houseFund.toString();
      filteredincomeList[18].income =
          teamDetails.data!.first.travelFund.toString();

      // model.incomeList[16].income =
      //     model.teamDetails!.data!.first.houseFund.toString();
      // model.incomeList[16].income =
      //     model.teamDetails!.data!.first.houseFund.toString();
      // getDashBoardData(catId: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${widget.userInfo.name} Portfolio'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserBusinessDetails(
                data: widget.userInfo,
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: (filteredincomeList.length) * 60,
                child: GridView.builder(
                  itemCount: filteredincomeList.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.9,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // if (filteredincomeList[index].path != null) {
                        //   context.router.pushNamed(widget
                        //       .model.filteredincomeList[index].path
                        //       .toString());
                        //   // context.router.push(PrimeTeamScreenRoute(
                        //   //     planName: filteredincomeList[index].name,
                        //   //     planId: widget.model.filteredincomeList[index].id!));
                        // } else {
                        //   Fluttertoast.showToast(msg: 'coming Soon');
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.whiteColor,
                          border: Border.all(
                              color: filteredincomeList[index].color ??
                                  Colors.transparent,
                              width: 3),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4,
                                offset: Offset(1, 2),
                                color: AppColors.containerShaddowbg,
                                spreadRadius: 2)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              filteredincomeList[index].image.toString(),
                              height: 35,
                              width: 35,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    filteredincomeList[index].income,
                                    style: AppTextStyle.black20
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,

                                  //   children: [
                                  //     // if (widget.model.filteredincomeList[index]
                                  //     //         .color !=
                                  //     //     null)
                                  //     //   Container(
                                  //     //     height: 20,
                                  //     //     width: 20,
                                  //     //     decoration: BoxDecoration(
                                  //     //       shape: BoxShape.circle,
                                  //     //       color: widget.model
                                  //     //           .filteredincomeList[index].color,
                                  //     //     ),
                                  //     //   ),
                                  //     if (widget.model.filteredincomeList[index]
                                  //             .color !=
                                  //         null)
                                  //       const SizedBox(
                                  //         width: AppSizes.size6,
                                  //       ),
                                  //     Text(
                                  //       widget.model.filteredincomeList[index].income,
                                  //       style: AppTextStyle.black20
                                  //           .copyWith(fontWeight: FontWeight.w600),
                                  //     ),
                                  //     const SizedBox(
                                  //       height: AppSizes.size10,
                                  //     ),
                                  //   ],
                                  // ),
                                  Text(
                                    filteredincomeList[index].name,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.regular14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
        FloatingActionButton(
            heroTag: "btn2",
            child: Image.asset(
              AppAssets.whatsapp,
            ),
            onPressed: () {
              if (widget.userInfo.mobile != null) {
                CommonMethod.whatsapp(
                    mobileNumber: widget.userInfo.mobile.toString());
              }
            }),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          heroTag: "btn1",
          child: Image.asset(AppAssets.phoneIcon),
          onPressed: () async {
            if (widget.userInfo.mobile != null) {
              await FlutterPhoneDirectCaller.callNumber(
                  widget.userInfo.mobile.toString());
            }
          },
        ),
      ]),
    );
  }
}
