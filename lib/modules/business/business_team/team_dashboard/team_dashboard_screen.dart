import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_model.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_presenter.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_view.dart';
import 'package:defenders/modules/business/business_widget/user_business_details.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TeamDashboardScreen extends StatefulWidget {
  final TeamDetailsInfoData data;
  const TeamDashboardScreen({super.key, required this.data});

  @override
  State<TeamDashboardScreen> createState() => _TeamDashboardScreenState();
}

class _TeamDashboardScreenState extends State<TeamDashboardScreen>
    implements TeamDashboardView {
  late TeamDashboardModel model;
  late BasicTeamDashboardPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = BasicTeamDashboardPresenter(list);
    presenter.updateView = this;
    presenter.getTeamDetails(
      userId: widget.data.id.toString(),
      context: context,
    );
  }

  @override
  void refreshModel(TeamDashboardModel businessDashboardModel) {
    model = businessDashboardModel;
    if (mounted) {
      setState(() {});
    }
  }

  List<DashboardIncomeList> list = [
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
    DashboardIncomeList(
        name: "Car Fund", catId: 0, income: " 0", image: AppAssets.b19),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${widget.data.name} Portfolio'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              UserBusinessDetails(
                data: widget.data,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: (model.incomeList.length) * 55,
                child: GridView.builder(
                  itemCount: model.incomeList.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.whiteColor,
                          border: Border.all(
                              color: model.incomeList[index].color ??
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
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              model.incomeList[index].image.toString(),
                              height: 35,
                              width: 35,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // if (model.incomeList[index]
                                      //         .color !=
                                      //     null)
                                      //   Container(
                                      //     height: 20,
                                      //     width: 20,
                                      //     decoration: BoxDecoration(
                                      //       shape: BoxShape.circle,
                                      //       color: model
                                      //           .incomeList[index].color,
                                      //     ),
                                      //   ),
                                      if (model.incomeList[index].color != null)
                                        const SizedBox(
                                          width: AppSizes.size6,
                                        ),
                                      Text(
                                        model.incomeList[index].income,
                                        style: AppTextStyle.black20.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: AppSizes.size10,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.incomeList[index].name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.regular14,
                                    ),
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
    );
  }
}
