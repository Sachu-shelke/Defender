import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/training_meeting/get_training_model.dart';
import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
import 'package:defenders/training_meeting/live_training_screen.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_model.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_presenter.dart';
import 'package:defenders/training_meeting/training_meeting_details/training_meeting_details_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TrainingMeetingDetailsScreen extends StatefulWidget {
  final GetTrainingData data;
  const TrainingMeetingDetailsScreen({super.key, required this.data});

  @override
  State<TrainingMeetingDetailsScreen> createState() =>
      _TrainingMeetingDetailsScreenState();
}

class _TrainingMeetingDetailsScreenState
    extends State<TrainingMeetingDetailsScreen>
    implements TrainingMeetingDetailsView {
  DateTime now = DateTime.now();

  late TrainingMeetingDetailsModel model;
  TrainingMeetingDetailsPresenter presenter =
      BasicTrainingMeetingDetailsPresenter();

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
  }

  @override
  void refreshModel(TrainingMeetingDetailsModel trainingModel) {
    model = trainingModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Training Details'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Banners(
            model: (GlobalSingleton.bannerList != null)
                ? GlobalSingleton.bannerList!
                : null,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_alarm_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.data.totalEnroll.toString())
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.share),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.data.totalInvite.toString())
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.data.name.toString(),
                  style: AppTextStyle.semiBold20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data.description.toString(),
                  style: AppTextStyle.regular14,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                    .format(DateTime.parse(
                              widget.data.meetingDate.toString(),
                            )))
                                .difference(
                                    DateTime.parse(DateTime.now().toString()))
                                .inMinutes <
                            5
                        //   now.isAfter(
                        //   DateTime.parse(
                        //     widget.data.meetingDate.toString(),
                        //   ),
                        // )
                        ) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LiveTrainingScreen(),
                        ),
                      );
                      // launchUrl(
                      //   Uri.parse(
                      //     widget.data.meetingLink.toString(),
                      //   ),
                      // );
                    } else {
                      widget.data.isEnroll = 1;
                      widget.data.totalEnroll =
                          (widget.data.totalEnroll ?? 0) + 1;
                      presenter.updateTraining(
                          context: context,
                          meetingId: widget.data.id.toString(),
                          isInvite: '0',
                          isEnroll: '1',
                          isJoin: '0');
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green.shade800,
                      ),
                      color: (DateTime.parse(
                                      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                          .format(DateTime.parse(
                                widget.data.meetingDate.toString(),
                              )))
                                  .difference(
                                      DateTime.parse(DateTime.now().toString()))
                                  .inMinutes <
                              5)
                          //  now.isAfter(
                          //   DateTime.parse(
                          //     widget.data.meetingDate.toString(),
                          //   ),
                          // )
                          ? Colors.green.shade800
                          : widget.data.isEnroll == 1
                              ? null
                              : Colors.green.shade800,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        (DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                        .format(DateTime.parse(
                                  widget.data.meetingDate.toString(),
                                )))
                                    .difference(DateTime.parse(
                                        DateTime.now().toString()))
                                    .inMinutes <
                                5)
                            // now.isAfter(
                            //   DateTime.parse(
                            //     widget.data.meetingDate.toString(),
                            //   ),
                            // )
                            ? 'Join'
                            : widget.data.isEnroll == 1
                                ? 'Enrolled'
                                : 'Enroll Now',
                        style: AppTextStyle.semiBold16.copyWith(
                            fontSize: 16,
                            color: (DateTime.parse(DateFormat(
                                                "yyyy-MM-dd HH:mm:ss.SSSSSS")
                                            .format(DateTime.parse(
                                      widget.data.meetingDate.toString(),
                                    )))
                                        .difference(DateTime.parse(
                                            DateTime.now().toString()))
                                        .inMinutes <
                                    5)
                                // now.isAfter(
                                //   DateTime.parse(
                                //     widget.data.meetingDate.toString(),
                                //   ),
                                // )
                                ? AppColors.whiteColor
                                : widget.data.isEnroll == 1
                                    ? Colors.green.shade800
                                    : AppColors.whiteColor),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     color: widget.data.isEnroll == 1
                  //         ? null
                  //         : Colors.green.shade800,
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       now.isAfter(
                  //         DateTime.parse(
                  //           widget.data.meetingDate.toString(),
                  //         ),
                  //       )
                  //           ? 'Join'
                  //           : widget.data.isEnroll == 1
                  //               ? 'Enrolled'
                  //               : 'Enroll Now',
                  //       style: AppTextStyle.semiBold16.copyWith(
                  //           fontSize: 16,
                  //           color: widget.data.isEnroll == 1
                  //               ? Colors.green.shade800
                  //               : AppColors.whiteColor),
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                width: AppSizes.size10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.data.isInvite = 1;
                    widget.data.totalInvite =
                        (widget.data.totalInvite ?? 0) + 1;
                    presenter.updateTraining(
                        context: context,
                        meetingId: widget.data.id.toString(),
                        isInvite: '1',
                        isEnroll: '0',
                        isJoin: '0');
                    setState(() {});
                    CommonMethod.referLink(
                        msg: widget.data.meetingDate!.toString().getDateTimeNew,
                        referCode:
                            GlobalSingleton.loginInfo!.data!.mobile.toString(),
                        name:
                            "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
                    // Share.share(widget.data.meetingLink.toString());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secoundColors,
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
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
