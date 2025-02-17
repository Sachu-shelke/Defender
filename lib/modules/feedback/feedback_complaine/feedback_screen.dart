import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_presenter.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen/feedback_reason_screen.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen_model.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

@RoutePage()
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>
    implements FeedbackView {
  FeedbackPresenter presenter = BasicFeedbackPresenter();
  late FeebackScreenModel model;
  @override
  void initState() {
    presenter.updateView = this;
    presenter.getCategories(userID: '', context: context);
    super.initState();
  }

  @override
  void refreshModel(FeebackScreenModel feedbackMode) {
    model = feedbackMode;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Problem Feedback'),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 5,
                        color: AppColors.appColors,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        children: [
                          Text('What Is Your',
                              textScaleFactor: 1.0,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                          Text('Problem?',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.feedbackCategoryData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              model.selectedCategoriesId = model
                                  .feedbackCategoryData[index].feedbackCatId
                                  .toString();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeedbackReasonScreen(
                                    model: model,
                                    presenter: presenter,
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
                                color: (index == 0 ||
                                        index == 3 ||
                                        index == 6 ||
                                        index == 9)
                                    ? const Color(0xFFFBEFE3)
                                    : (index == 1 ||
                                            index == 4 ||
                                            index == 7 ||
                                            index == 10)
                                        ? const Color(0xFFEFFAF1)
                                        : const Color(0xFFEBF4FB),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(1, 3),
                                      color: AppColors.backgroundColor,
                                      spreadRadius: 1)
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // color: ,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        model.feedbackCategoryData[index]
                                            .categoryName
                                            .toString(),
                                        textScaleFactor: 1.0,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    if (model.feedbackCategoryData[index]
                                            .imageurl
                                            .toString() !=
                                        'null')
                                      Container(
                                        width: 57.0,
                                        height: 58.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(model
                                                  .feedbackCategoryData[index]
                                                  .imageurl!)),
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
                          ),
                        ],
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
