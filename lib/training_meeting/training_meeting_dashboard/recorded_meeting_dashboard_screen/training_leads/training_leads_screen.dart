import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/model/training_meeting/get_recorded_categories_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_model.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_presenter.dart';
import 'package:defenders/training_meeting/training_meeting_dashboard/recorded_meeting_dashboard_screen/training_leads/training_leads_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// @RoutePage()
class TrainingLeadsScreen extends StatefulWidget {
  final ChildCategory childCat;
  const TrainingLeadsScreen({super.key, required this.childCat});

  @override
  State<TrainingLeadsScreen> createState() => _TrainingLeadsScreenState();
}

class _TrainingLeadsScreenState extends State<TrainingLeadsScreen>
    implements TrainingLeadsView {
  late TrainingLeadsModel model;
  TrainingLeadsPresenter presenter = BasicTrainingLeadsPresenter();
  late YoutubePlayerController _controller;
  int selectedIndex = 0;

  // List videoList = [];

  int? selectedPlayVideo;
  bool isVideoPause = true;
  @override
  void initState() {
    presenter.updateView = this;
    presenter.getRecordedTraining(
        context: context, id: widget.childCat.id.toString());
    super.initState();
  }

  @override
  void refreshModel(TrainingLeadsModel trainingModel) {
    model = trainingModel;
    if (mounted) {
      setState(() {});
    }
  }

  // List traningList = [
  //   {
  //     'image': AppAssets.courseMarketing,
  //     'title': 'Basic App Training',
  //   },
  //   {
  //     'image': AppAssets.courseMarketing,
  //     'title': 'Learn How to Sell',
  //   },
  //   {
  //     'image': AppAssets.courseMarketing,
  //     'title': 'Grow Your Customer Base',
  //   },
  // ];

  @override
  void dispose() {
    if (selectedPlayVideo != null) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: widget.childCat.categoryName),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: model.videoList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedPlayVideo == index) {
                              // _controller.pause();
                              // if (isVideoPause == false) {
                              //   isVideoPause = true;
                              //   _controller.pause();
                              // } else {
                              //   isVideoPause = true;
                              //   _controller.play();
                              // }
                            } else {
                              if (selectedPlayVideo != null) {
                                _controller.dispose();
                              }
                              isVideoPause = false;
                              selectedPlayVideo = index;

                              _controller = YoutubePlayerController(
                                initialVideoId: YoutubePlayer.convertUrlToId(
                                        model.videoList[selectedPlayVideo!]
                                            .videoLink
                                            .toString()) ??
                                    '',
                                flags: const YoutubePlayerFlags(
                                    autoPlay: true,
                                    disableDragSeek: true,
                                    loop: false,
                                    // isLive: false,
                                    // forceHD: false,
                                    // enableCaption: false,
                                    // controlsVisibleAtStart: false,
                                    // hideThumbnail: true,
                                    // useHybridComposition: false,
                                    // hideControls: false,
                                    showLiveFullscreenButton: false),
                              );
                            }

                            setState(() {});
                          }, //image
                          child: selectedPlayVideo == index
                              ? YoutubePlayer(
                                  controller: _controller,
                                  bottomActions: const [],
                                  topActions: const [],
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.network(
                                      'https://apis.jobbershubecommerce.in/${model.videoList[selectedPlayVideo ?? 0].thumbnail}',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                    const Positioned(
                                        child: Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                    ))
                                  ],
                                ),
                        ),

                        // Container(
                        //   height: 150,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     image: const DecorationImage(
                        //         image: AssetImage(AppAssets.courseMarketing),
                        //         fit: BoxFit.fill),
                        //   ),
                        // ),
                        const SizedBox(
                          height: AppSizes.size10,
                        ),
                        Text(
                          model.videoList[index].title.toString(),
                          style: AppTextStyle.bold14,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
