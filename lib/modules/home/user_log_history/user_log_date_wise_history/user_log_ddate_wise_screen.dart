import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/model/home_model/royality_progress_history_model.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_mode.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_presenter.dart';
import 'package:defenders/modules/home/user_log_history/user_log_date_wise_history/user_log_ddate_wise_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class UserLogDateWiseScreen extends StatefulWidget {
  const UserLogDateWiseScreen({super.key});

  @override
  State<UserLogDateWiseScreen> createState() => _UserLogDateWiseScreenState();
}

class _UserLogDateWiseScreenState extends State<UserLogDateWiseScreen>
    implements UserLogDateWiseView {
  late UserLogDateWiseHistoryModel model;
  UserLogDateWiseHistoryPresenter presenter =
      BasicUserLogDateWiseHistoryPresenter();
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.userLogHistory(
        context: context,
        date: DateFormat('yyyy-MM-dd').format(today).toString());
  }

  @override
  void refreshModel(UserLogDateWiseHistoryModel homeModel) {
    model = homeModel;
    if (mounted) {
      setState(() {});
    }
  }

  String checkTaskStatus() {
    for (var task in model.royalityModel) {
      if (task.taskStatus == 'Pending') {
        return 'Pending';
      }
    }
    return 'Completed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Royality Progress History"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            InkWell(
              onTap: () async {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1995),
                  lastDate: DateTime.now(),
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      today = date;
                      presenter.userLogHistory(
                          context: context,
                          date: DateFormat('yyyy-MM-dd')
                              .format(today)
                              .toString());
                    });
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 14, right: 10),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(today).toString(),
                  style: AppTextStyle.semiBold18.copyWith(
                      color: AppColors.blackColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress History',
                  style: AppTextStyle.semiBold22,
                ),
                // Text(
                //   checkTaskStatus(),
                //   style: AppTextStyle.semiBold22.copyWith(
                //       color: checkTaskStatus() == "Pending"
                //           ? Colors.red
                //           : Colors.green),
                // ),
              ],
            ), //checkTaskStatus
            const SizedBox(
              height: 8,
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

  Widget customProgressBar(UserLogDateHistory data, int index) {
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
