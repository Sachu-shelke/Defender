import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTrainingScreen extends StatefulWidget {
  const YoutubeTrainingScreen({super.key});

  @override
  State<YoutubeTrainingScreen> createState() => _YoutubeTrainingScreenState();
}

class _YoutubeTrainingScreenState extends State<YoutubeTrainingScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("") ?? '',
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Mirror Training'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {}, //image
                    child: YoutubePlayer(
                      controller: _controller,
                      bottomActions: const [],
                      topActions: const [],
                    )),

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
                  "dsc",
                  style: AppTextStyle.bold14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
