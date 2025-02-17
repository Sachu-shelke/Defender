import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/modules/notification/notification_model.dart';
import 'package:defenders/modules/notification/notification_presenter.dart';
import 'package:defenders/modules/notification/notification_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/no_transaction_widget.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    implements NotificationView {
  NotificationPresenter presenter = BasicNotificationPresenter();
  late NotificationScreenModel model;
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    _scrollController.addListener(_scrollListener);
    presenter.getNotification(page: page, context: context);
  }

  _scrollListener() {
    if (_scrollController.position.maxScrollExtent / 2 ==
        (_scrollController.offset) / 2) {
      setState(() {
        page++;
      });
      // presenter.getGraphics(page: page, catId: widget.categoriesID);
    }
  }

  @override
  void refreshModel(NotificationScreenModel redeemModel) {
    model = redeemModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification'),
      body: Stack(
        children: [
          if (model.notificationdata.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                model.notificationdata.length > 8
                    ?
                    // model.lastPageIndex >= page
                    //     ?
                    'Data is loading...'
                    // :
                    //     'Data is Finish'
                    : "",
                style: AppTextStyle.semiBold16,
              ),
            ),
          Column(
            children: [
              if (model.notificationdata.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: model.notificationdata.length,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                                offset: const Offset(
                                    1.0, 1.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      model.notificationdata[index].title
                                          .toString(),
                                      textScaleFactor: 1.0,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (model.notificationdata[index]
                                          .entryDatetime !=
                                      null)
                                    Text(
                                      // DateTime.parse(element.entryDatetime.toString())
                                      // .toString(),
                                      DateFormat('dd-MM-yyyy hh:mm:ss')
                                          .parse(model.notificationdata[index]
                                              .entryDatetime
                                              .toString())
                                          .toString()
                                          .getDateTime, //  widget.model.title.toString(),textScaleFactor: 1.0,
                                      textScaleFactor: 1.0,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.greyColor),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                model.notificationdata[index].body.toString(),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackColor),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // if (element.image != null)
                              //   CachedNetworkImage(
                              //     height: 150,
                              //     width: MediaQuery.of(context).size.width,
                              //     imageUrl: element.image!,
                              //     errorWidget: ((context, url, error) =>
                              //         Container()),
                              //     fit: BoxFit.fill,
                              //   ),
                            ],
                          ),
                        );
                      }),
                ),
              // GroupedListView<dynamic, String>(
              //     elements: model.notificationdata,
              //     groupBy: (element) => element.entryDatetime.toString(),
              //     groupComparator: (value1, value2) => value2.compareTo(value1),
              //     itemComparator: (item1, item2) => DateFormat('dd-MM-yyyy')
              //         .parse(item1.entryDatetime.toString())
              //         .toString()
              //         .getSuccessDateFormat
              //         .compareTo(DateFormat('dd-MM-yyyy')
              //             .parse(item2.entryDatetime.toString())
              //             .toString()
              //             .getSuccessDateFormat),
              //     order: GroupedListOrder.ASC,
              //     useStickyGroupSeparators: true,
              //     groupSeparatorBuilder: (String value) => Text(
              //           DateTime.now()
              //                       .difference(
              //                           DateFormat('dd-MM-yyyy hh:mm:ss')
              //                               .parse(value.toString()))
              //                       .inDays >
              //                   3
              //               ? DateFormat('dd-MM-yyyy').format(
              //                   DateFormat('dd-MM-yyyy hh:mm:ss')
              //                       .parse(value.toString()))
              //               : DateTime.now()
              //                           .difference(
              //                               DateFormat('dd-MM-yyyy hh:mm:ss')
              //                                   .parse(value.toString()))
              //                           .inDays ==
              //                       0
              //                   ? 'Today'
              //                   : ('${DateTime.now().difference(DateFormat('dd-MM-yyyy hh:mm:ss').parse(value.toString())).inDays} Day ago'),
              //           textAlign: TextAlign.left,
              //           textScaleFactor: 1.0,
              //           style: const TextStyle(
              //               color: AppColors.secoundColors,
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold),

              //           //     .toString()
              //         ),
              //     itemBuilder: (c, element) {
              //       return Container(
              //         margin: const EdgeInsets.symmetric(
              //             horizontal: 20, vertical: 10),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 10, vertical: 10),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(8.0),
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.3),
              //               blurRadius: 1.0,
              //               spreadRadius: 0.0,
              //               offset: const Offset(
              //                   1.0, 1.0), // shadow direction: bottom right
              //             )
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Expanded(
              //                   child: Text(
              //                     element.title.toString(),
              //                     textScaleFactor: 1.0,
              //                     style: const TextStyle(
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // DateTime.parse(element.entryDatetime.toString())
              //                   // .toString(),
              //                   DateFormat('dd-MM-yyyy hh:mm:ss')
              //                       .parse(element.entryDatetime.toString())
              //                       .toString()
              //                       .getTimeFormat, //  widget.model.title.toString(),textScaleFactor: 1.0,
              //                   textScaleFactor: 1.0,
              //                   style: const TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.greyColor),
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               element.body.toString(),
              //               textScaleFactor: 1.0,
              //               style: const TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w400,
              //                   color: AppColors.blackColor),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             // if (element.image != null)
              //             //   CachedNetworkImage(
              //             //     height: 150,
              //             //     width: MediaQuery.of(context).size.width,
              //             //     imageUrl: element.image!,
              //             //     errorWidget: ((context, url, error) =>
              //             //         Container()),
              //             //     fit: BoxFit.fill,
              //             //   ),
              //           ],
              //         ),
              //       );
              //     }),
              if (model.notificationdata.isEmpty)
                const Expanded(
                  child: NoTransaction(
                    str: 'No Notification Found',
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
