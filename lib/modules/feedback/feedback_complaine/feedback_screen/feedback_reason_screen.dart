import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_presenter.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen/add_feedback_screen.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen_model.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

@RoutePage()
class FeedbackReasonScreen extends StatefulWidget {
  final FeebackScreenModel model;
  final FeedbackPresenter presenter;
  const FeedbackReasonScreen(
      {super.key, required this.model, required this.presenter});

  @override
  State<FeedbackReasonScreen> createState() => _FeedbackReasonScreenState();
}

class _FeedbackReasonScreenState extends State<FeedbackReasonScreen>
    implements FeedbackView {
  @override
  void initState() {
    widget.presenter
        .getReasonById(
            category: widget.model.selectedCategoriesId.toString(),
            context: context)
        .then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void refreshModel(FeebackScreenModel feedbackMode) {
    // model = feedbackMode;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Problem Feedback",
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'What Is Your Reason?',
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.model.feedbackCategoryDatabyId.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget.model.selectedReasonId = widget.model
                              .feedbackCategoryDatabyId[index].feedbackReasonId;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFeedbackScreen(
                                model: widget.model,
                                presenter: widget.presenter,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDCBA),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(1, 3),
                                  color: AppColors.backgroundColor,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // color: const
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.model.feedbackCategoryDatabyId[index]
                                        .reasonName
                                        .toString(),
                                    textScaleFactor: 1.0,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (widget.model.feedbackCategoryDatabyId[index]
                                        .img
                                        .toString() !=
                                    'null')
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(widget
                                              .model
                                              .feedbackCategoryDatabyId[index]
                                              .img!)
                                          // CachedNetworkImageProvider(
                                          //     "${}"),
                                          ),
                                    ),
                                  ),
                                // Container(
                                //   child: CachedNetworkImageProvider(
                                //   feedbackCategoryData[index].imageurl.toString()
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
