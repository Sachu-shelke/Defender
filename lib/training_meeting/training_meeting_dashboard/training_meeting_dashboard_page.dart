import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_screen.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_screen.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TrainingMeetingDashboardPage extends StatefulWidget {
  final bool isFromMain;
  const TrainingMeetingDashboardPage({super.key, required this.isFromMain});

  @override
  State<TrainingMeetingDashboardPage> createState() =>
      _TrainingMeetingDashboardPageState();
}

class _TrainingMeetingDashboardPageState
    extends State<TrainingMeetingDashboardPage> {
  int selectedScrenTypesIndex = 0;
  List detailsBenifitsList = [
    // {'name': 'Live Traning', 'isSelected': true},
    {'name': 'Upcoming Live', 'isSelected': true},
    {'name': 'Recorded Traning', 'isSelected': false},
    // {'name': 'Subscribed Couress', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromMain == false
          ? const CustomAppBar(title: 'Training')
          : null,
      body: Column(
        children: [
          const SizedBox(
            height: AppSizes.size10,
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detailsBenifitsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedScrenTypesIndex = index;
                      for (var i = 0; i < detailsBenifitsList.length; i++) {
                        detailsBenifitsList[i]['isSelected'] = false;
                      }
                      detailsBenifitsList[index]['isSelected'] = true;
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: selectedScrenTypesIndex == index
                              ? AppColors.appColors
                              : const Color(0xff3F3D3C),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          detailsBenifitsList[index]['name'],
                          style: AppTextStyle.semiBold14
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          // if (selectedScrenTypesIndex == 0)
          //   const Expanded(
          //     child: LiveTrainingScreen(),
          //   ),
          if (selectedScrenTypesIndex == 0)
            const Expanded(
              child: TrainingMeetingDashboardScreen(
                index: 0,
              ),
            ),
          if (selectedScrenTypesIndex == 2)
            const Expanded(
              child: RecordedMeetingDashboardScreen(),
            ),
        ],
      ),
    );
  }
}
