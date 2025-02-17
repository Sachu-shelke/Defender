import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_presenter.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/recorded_meeting_dashboard_view.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_screen.dart';

class RecordedMeetingDashboardScreen extends StatefulWidget {
  const RecordedMeetingDashboardScreen({super.key});

  @override
  State<RecordedMeetingDashboardScreen> createState() =>
      _RecordedMeetingDashboardScreenState();
}

class _RecordedMeetingDashboardScreenState
    extends State<RecordedMeetingDashboardScreen>
    implements RecordedMeetingDashboardView {
  late RecordedMeetingDashboardModel model;
  RecordedMeetingDashboardPresenter presenter =
      BasicRecordedMeetingDashboardPresenter();

  @override
  void initState() {
    presenter.updateView = this;
    presenter.getRecordedTraining(context: context);
    super.initState();
  }

  @override
  void refreshModel(RecordedMeetingDashboardModel trainingModel) {
    model = trainingModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (model.categoriesList.isNotEmpty)
            Expanded(
              child: GridView.builder(
                itemCount: model.categoriesList[0].childCategory!.length,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingLeadsScreen(
                            childCat:
                                model.categoriesList[0].childCategory![index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(model.categoriesList[0]
                                    .childCategory![index].categoryImage
                                    .toString()),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.size6,
                        ),
                        Text(
                          model.categoriesList[0].childCategory![index]
                              .categoryName
                              .toString(),
                          style: AppTextStyle.bold14,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
