// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/training_meeting/get_training_model.dart';
import 'package:defenders/training_meeting/live_training_screen.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_presenter.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/training_meeting_dashboard_screen/training_meeting_dashboard_view.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_screen.dart';

class TrainingMeetingDashboardScreen extends StatefulWidget {
  final int index;
  const TrainingMeetingDashboardScreen({super.key, required this.index});

  @override
  State<TrainingMeetingDashboardScreen> createState() =>
      _TrainingMeetingDashboardScreenState();
}

class _TrainingMeetingDashboardScreenState
    extends State<TrainingMeetingDashboardScreen>
    implements TrainingMeetingDashboardView {
  DateTime joiningDate = DateTime.now();
  DateTime now = DateTime.now();
  late TrainingMeetingDashboardModel model;
  TrainingMeetingDashboardPresenter presenter =
      BasicTrainingMeetingDashboardPresenter();

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.getTrainingData(
        context: context,
        date: '${joiningDate.year}-${joiningDate.month}-${joiningDate.day}');
  }

  @override
  void refreshModel(TrainingMeetingDashboardModel trainingModel) {
    model = trainingModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // widget.isFromHomeScreen == true
        //     ? Align(
        //         alignment: Alignment.centerLeft,
        //         child: ListView.builder(
        //             itemCount: model.data.length,
        //             // physics: const ScrollPhysics(),
        //             padding: const EdgeInsets.symmetric(horizontal: 10),
        //             scrollDirection: Axis.horizontal,
        //             shrinkWrap: true,
        //             itemBuilder: (context, index) {
        //               return customContainer(
        //                   data: model.data[index], cont: context);
        //             }),
        //       )
        //     :
        ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(
          height: AppSizes.size10,
        ),
        // InkWell(
        //   onTap: (){
        //      Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => const LiveTrainingScreen(),
        //                 ),
        //               );
        //   },
        //   child: Container(
        //     height: 100,
        //     width: 100,
        //     color: Colors.red,
        //   ),
        // ),
        // Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () async {
        //         final datePick = await showDatePicker(
        //           context: context,
        //           initialDate: DateTime.now(),
        //           firstDate: DateTime(2024),
        //           lastDate: DateTime(2025),
        //         );
        //         if (datePick != null && datePick != joiningDate) {
        //           setState(() {
        //             joiningDate = datePick;
        //             presenter.getTrainingData(
        //                 context: context,
        //                 date:
        //                     "${joiningDate.year}-${joiningDate.month}-${joiningDate.day}");
        //           });
        //         }
        //       },
        //       child: Container(
        //         height: 50,
        //         width: 150,
        //         margin: const EdgeInsets.symmetric(horizontal: 10),
        //         padding: const EdgeInsets.symmetric(horizontal: 15),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: AppColors.blackColor),
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //         child: Row(
        //           children: [
        //             Text(
        //               joiningDate != null
        //                   ? '${joiningDate.year}-${joiningDate.month}-${joiningDate.day}'
        //                   : 'date',
        //               textScaleFactor: 1.0,
        //               style: TextStyle(
        //                 color: Colors.grey.shade800,
        //                 fontSize: 16,
        //               ),
        //             ),
        //             const Spacer(),
        //             const Icon(
        //               Icons.calendar_month_outlined,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        ListView.builder(
            itemCount: model.data.length,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return customContainer(data: model.data[index], cont: context);
            }),
      ],
    );
  }

  Widget customContainer({
    required GetTrainingData data,
    required BuildContext cont,
  }) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingMeetingDetailsScreen(
              data: data,
            ),
          ),
        );
        // ignore: unused_local_variable
        // bool isLaunch = await launch(data.meetingLink.toString());
        // presenter.updateTraining(
        //     context: context,
        //     meetingId: data.id.toString(),
        //     isInvite: '0',
        //     isEnroll: '0',
        //     isJoin: '1');
      },
      child: Container(
        width: null,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                offset: const Offset(1, 2),
                color: AppColors.greyColor.withOpacity(0.4),
                spreadRadius: 1)
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: cont,
                  isScrollControlled: true,
                  backgroundColor: Colors.black.withOpacity(0.3),
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: AppColors.whiteColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Image.network(
                            data.image.toString(),
                            height: 330,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.network(
                data.image.toString(),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: AppSizes.size6,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name.toString(),
                    maxLines: 1,
                    style: AppTextStyle.semiBold18,
                  ),
                  const SizedBox(
                    height: AppSizes.size4,
                  ),
                  Text(
                    data.meetingDate!.toString().getDateTimeNew,
                    style: AppTextStyle.semiBold18
                        .copyWith(fontSize: 18, color: AppColors.appColors),
                  ),
                  const SizedBox(
                    height: AppSizes.size4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // data.isEnroll = 1;
                            // data.totalEnroll = (data.totalEnroll ?? 0) + 1;
                            // presenter.updateTraining(
                            //     context: context,
                            //     meetingId: data.id.toString(),
                            //     isInvite: '0',
                            //     isEnroll: '1',
                            //     isJoin: '0');

                            if (DateTime.parse(
                                        DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                            .format(DateTime.parse(
                                  data.meetingDate.toString(),
                                )))
                                    .difference(DateTime.parse(
                                        DateTime.now().toString()))
                                    .inMinutes <
                                5) {
                              // launchUrl(
                              //   Uri.parse(
                              //     data.meetingLink.toString(),
                              //   ),
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LiveTrainingScreen()));
                            } else {
                              data.isEnroll = 1;
                              data.totalEnroll = (data.totalEnroll ?? 0) + 1;
                              presenter.updateTraining(
                                  context: context,
                                  meetingId: data.id.toString(),
                                  isInvite: '0',
                                  isEnroll: '1',
                                  isJoin: '0');
                              setState(() {});
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green.shade800,
                              ),
                              color:
                                  //  now.isAfter(
                                  //   DateTime.parse(
                                  //     data.meetingDate.toString(),
                                  //   ),
                                  // )
                                  (DateTime.parse(DateFormat(
                                                      "yyyy-MM-dd HH:mm:ss.SSSSSS")
                                                  .format(DateTime.parse(
                                            data.meetingDate.toString(),
                                          )))
                                              .difference(DateTime.parse(
                                                  DateTime.now().toString()))
                                              .inMinutes <
                                          5)
                                      ? Colors.green.shade800
                                      : data.isEnroll == 1
                                          ? null
                                          : Colors.green.shade800,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                (DateTime.parse(DateFormat(
                                                    "yyyy-MM-dd HH:mm:ss.SSSSSS")
                                                .format(DateTime.parse(
                                          data.meetingDate.toString(),
                                        )))
                                            .difference(DateTime.parse(
                                                DateTime.now().toString()))
                                            .inMinutes <
                                        5)
                                    // now.isAfter(
                                    //   DateTime.parse(
                                    //     data.meetingDate.toString(),
                                    //   ),
                                    // )
                                    ? 'Join'
                                    : data.isEnroll == 1
                                        ? 'Enrolled'
                                        : 'Enroll Now',
                                style: AppTextStyle.semiBold16.copyWith(
                                    fontSize: 16,
                                    color: (DateTime.parse(DateFormat(
                                                        "yyyy-MM-dd HH:mm:ss.SSSSSS")
                                                    .format(DateTime.parse(
                                              data.meetingDate.toString(),
                                            )))
                                                .difference(DateTime.parse(
                                                    DateTime.now().toString()))
                                                .inMinutes <
                                            10)
                                        //  now.isAfter(
                                        //   DateTime.parse(
                                        //     data.meetingDate.toString(),
                                        //   ),
                                        // )
                                        ? AppColors.whiteColor
                                        : data.isEnroll == 1
                                            ? Colors.green.shade800
                                            : AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            data.isInvite = 1;
                            data.totalInvite = (data.totalInvite ?? 0) + 1;
                            presenter.updateTraining(
                                context: context,
                                meetingId: data.id.toString(),
                                isInvite: '1',
                                isEnroll: '0',
                                isJoin: '0');
                            setState(() {});

                            CommonMethod.referLink(
                                msg:
                                    data.meetingDate!.toString().getDateTimeNew,
                                referCode: GlobalSingleton
                                    .loginInfo!.data!.mobile
                                    .toString(),
                                name:
                                    "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
                            // Share.share(data.meetingLink.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Invite',
                                style: AppTextStyle.semiBold16.copyWith(
                                    fontSize: 16, color: AppColors.whiteColor),
                              ),
                            ),
                          ),
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
    );
  }
}
