import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_presenter.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_view.dart';
import 'package:defenders/modules/business/business_dashboard/portfolio/company_portfolio.dart';
import 'package:defenders/modules/business/business_dashboard/portfolio/my_portfolio.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_screen.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen>
    implements BusinessDashboardView {
  late BusinessDashboardModel model;
  late BasicBusinessDashboardPresenter presenter;

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
      name: "Mobile Fund",
      catId: 0,
      image: AppAssets.b17,
      income: " 0",
    ),
    DashboardIncomeList(
        name: "Car Fund", catId: 0, income: " 0", image: AppAssets.b19),
    DashboardIncomeList(
        name: "Gold Royality", catId: 3, income: " 0", image: AppAssets.b12),
    DashboardIncomeList(
        name: "House Fund", catId: 0, income: " 0", image: AppAssets.b16),
    DashboardIncomeList(
        name: "Platinum Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b14),
    DashboardIncomeList(
        name: "Travel Fund", catId: 0, income: " 0", image: AppAssets.b17),
    DashboardIncomeList(
        name: "Diamond Royality", catId: 3, income: " 0", image: AppAssets.b13),
    DashboardIncomeList(
      name: "Comunity Fund",
      catId: 0,
      image: AppAssets.b18,
      income: " 0",
    ),
    DashboardIncomeList(
        name: "Double Diamond Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b13),
    DashboardIncomeList(
        name: "Ambassdor Royality",
        catId: 3,
        income: " 0",
        image: AppAssets.b15),
  ];

  @override
  void initState() {
    super.initState();
    presenter = BasicBusinessDashboardPresenter(list);
    presenter.updateView = this;
    if (GlobalSingleton.isPortfolioShoe == "1") {
      model.selectedBusinessScreenIndex = 0;
    } else {
      model.selectedBusinessScreenIndex = 1;
    }
    presenter.getTeamDetails(
      userId: GlobalSingleton.loginInfo!.data!.id.toString(),
      context: context,
    );
    presenter.getCompanyDetails(
      userId: GlobalSingleton.loginInfo!.data!.id.toString(),
    );
    setState(() {});
  }

  @override
  void refreshModel(BusinessDashboardModel businessDashboardModel) {
    model = businessDashboardModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        children: [
          Row(
            children: [
              (GlobalSingleton.isPortfolioShoe == "1")
                  ? Expanded(
                      child: dashboardButton(
                      title: 'Company Portfolio',
                      isselected: model.selectedBusinessScreenIndex == 0,
                      onTap: () {
                        model.selectedBusinessScreenIndex = 0;
                        GlobalUpdateNotifier.of(context)?.onGlobalUpdate();
                        setState(() {});
                      },
                    ))
                  : Expanded(
                      child: dashboardButton(
                      title: 'My Royality Progresss',
                      isselected: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserLogHistoryScreen(),
                          ),
                        );
                      },
                    )),
              //  InkWell(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const UserLogHistoryScreen(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       height: AppSizes.size50,
              //       margin: const EdgeInsets.symmetric(horizontal: 30),
              //       decoration: BoxDecoration(
              //           gradient: AppColors.circleGradient,
              //           color: Colors.white,
              //           borderRadius:
              //               BorderRadius.circular(AppSizes.size14),
              //           border: Border.all(color: Colors.transparent)),
              //       child: Center(
              //         child: Text(
              //           'My Royality Progresss',
              //           style: AppTextStyle.semiBold16.copyWith(
              //             color: AppColors.whiteColor,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              const SizedBox(
                width: AppSizes.size6,
              ),
              Expanded(
                  child: dashboardButton(
                title: 'My Portfolio',
                isselected: model.selectedBusinessScreenIndex == 1,
                onTap: () {
                  model.selectedBusinessScreenIndex = 1;
                  GlobalUpdateNotifier.of(context)?.onGlobalUpdate();
                  setState(() {});
                },
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (model.selectedBusinessScreenIndex == 0)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLogHistoryScreen(),
                  ),
                );
              },
              child: Container(
                height: AppSizes.size50,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    gradient: AppColors.circleGradient,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.size14),
                    border: Border.all(color: Colors.transparent)),
                child: Center(
                  child: Text(
                    'My Royality Progresss',
                    style: AppTextStyle.semiBold16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          if (model.selectedBusinessScreenIndex == 0)
            CompanyPortfolio(
              model: model,
            ),
          if (model.selectedBusinessScreenIndex == 1)
            MyPortfolio(
              model: model,
              presenter: presenter,
            ),
        ],
      ),
    );
  }

  Widget dashboardButton(
      {final Function()? onTap,
      required bool isselected,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: AppSizes.size50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: isselected != false ? AppColors.circleGradient : null,
            color: isselected != true ? Colors.white : null,
            borderRadius: BorderRadius.circular(AppSizes.size14),
            border: Border.all(
                color: isselected != true
                    ? AppColors.secoundColors
                    : Colors.transparent)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.semiBold16.copyWith(
            color: isselected != true
                ? AppColors.secoundColors
                : AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

class GlobalUpdateNotifier extends InheritedWidget {
  final VoidCallback onGlobalUpdate;

  const GlobalUpdateNotifier({
    super.key,
    required super.child,
    required this.onGlobalUpdate,
  });

  static GlobalUpdateNotifier? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalUpdateNotifier>();
  }

  @override
  bool updateShouldNotify(GlobalUpdateNotifier oldWidget) {
    return false;
  }
}
