import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/model/home_model/royality_progress_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_screen.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_presenter.dart';
import 'package:defenders/modules/home/user_log_history/user_log_history_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';

class UserLogHistoryScreen extends StatefulWidget {
  const UserLogHistoryScreen({super.key});

  @override
  State<UserLogHistoryScreen> createState() => _UserLogHistoryScreenState();
}

class _UserLogHistoryScreenState extends State<UserLogHistoryScreen>
    implements UserLogHistoryView {
  late UserLogHistoryModel model;
  UserLogHistoryPresenter presenter = BasicUserLogHistoryPresenter();

  int selectedIndex = 0;

  List taskStatusList = [
    'Today Task',
    'Task History',
    'Achivers',
  ];

  final colorList = <Color>[
    AppColors.secoundColors,
    AppColors.appColors,
  ];

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.userLogHistory(context: context);
  }

  @override
  void refreshModel(UserLogHistoryModel homeModel) {
    model = homeModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Royality Progress',
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLogDateWiseScreen(),
                    ),
                  );
                },
                child: Text(
                  "History",
                  style: AppTextStyle.semiBold16
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Text(
              'Daily Progress',
              style: AppTextStyle.semiBold22,
            ),
            if (model.dataMap != null)
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.appColors)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSizes.size10,
                          ),
                          Text(
                            'Progress',
                            style: AppTextStyle.semiBold20,
                          ),
                          const SizedBox(
                            height: AppSizes.size6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Container(
                              //   height: 15,
                              //   width: 30,
                              //   margin: const EdgeInsets.only(right: 10),
                              //   color: AppColors.secoundColors,
                              // ),
                              Expanded(
                                child: Text(
                                  "${model.dataMap!['Achieve Business']!.toStringAsFixed(2)}%",
                                  style: AppTextStyle.semiBold16
                                      .copyWith(color: AppColors.secoundColors),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSizes.size6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Container(
                              //   height: 15,
                              //   width: 30,
                              //   margin: const EdgeInsets.only(right: 10),
                              //   color: AppColors.appColors,
                              // ),
                              Expanded(
                                child: Text(
                                  "${model.dataMap!['Remaining Business ']!.toStringAsFixed(2)}%",
                                  style: AppTextStyle.semiBold16
                                      .copyWith(color: AppColors.appColors),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSizes.size10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.secoundColors,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Complete",
                                        style: AppTextStyle.regular12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.appColors,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "In Complete",
                                        style: AppTextStyle.regular12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    PieChart(
                      dataMap: model.dataMap!,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,

                      chartRadius: MediaQuery.of(context).size.width / 2.3,
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
                  ],
                ),
              ),
            const SizedBox(
              height: 8,
            ),
            // SizedBox(
            //   height: 40,
            //   child: ListView.builder(
            //       itemCount: taskStatusList.length,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return InkWell(
            //           onTap: () {
            //             selectedIndex = index;
            //             setState(() {});
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.symmetric(horizontal: 5),
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 5),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               border: Border.all(color: AppColors.appColors),
            //               gradient: selectedIndex == index
            //                   ? AppColors.circleGradient
            //                   : null,
            //             ),
            //             child: Center(
            //               child: Text(
            //                 taskStatusList[index],
            //                 style: AppTextStyle.semiBold14.copyWith(
            //                     color: selectedIndex != index
            //                         ? AppColors.appColors
            //                         : AppColors.whiteColor),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "You need to complete any 3 tasks to get today's royality",
              style:
                  AppTextStyle.semiBold12.copyWith(color: AppColors.appColors),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: model.royalityModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child:
                          customProgressBar(model.royalityModel[index], index),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget customProgressBar(RoyalityProgressData data, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.greyColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index + 1}. ${data.task}",
            style: AppTextStyle.regular14,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: AppColors.appColors,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.secoundColors,
                      ),
                      minHeight: 12,
                      value: progressCalculator(
                          progressCount: (data.taskCount ?? 0),
                          totalCount: data.targetCount ?? 0),
                    ),
                    if ((data.targetCount ?? 0) > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (data.taskCount ?? 0).toString(),
                              style: AppTextStyle.semiBold16,
                            ),
                            Text(
                              max(
                                      (data.targetCount ?? 0) -
                                          (data.taskCount ?? 0),
                                      0)
                                  .toString(),
                              style: AppTextStyle.semiBold16,
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                (data.taskCount ?? 0) >= (data.targetCount ?? 0)
                    ? 'Completed'
                    : 'Pending',
                style: AppTextStyle.semiBold12,
              )
            ],
          ),
        ],
      ),
    );
  }

  double progressCalculator({
    required num progressCount,
    required num totalCount,
  }) {
    double cc = (progressCount) / totalCount;

    return cc;
  }
}

// Map cdcd = {
//   "status": 200,
//   "message": "Log Updated",
//   "data": [
//     {
//       "task": "Login app 3 times in a day Morning/afternoon/evening",
//       "target_count": 3,
//       "count(t.user_id)": 1
//     },
//     {
//       "task": "Share Mirror Business Refer link at list 3 people in a day",
//       "target_count": 3,
//       "count(t.user_id)": 1
//     }
//   ]
// };
