// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/income_passbook/income_passbook_model.dart';
import 'package:defenders/modules/income_passbook/income_passbook_presenter.dart';
import 'package:defenders/modules/income_passbook/income_passbook_view.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

@RoutePage()
class IncomePassbookScreen extends StatefulWidget {
  final bool isFromDrawer;
  final String? filter;
  const IncomePassbookScreen(
      {super.key, this.filter, required this.isFromDrawer});

  @override
  State<IncomePassbookScreen> createState() => _IncomePassbookScreenState();
}

class _IncomePassbookScreenState extends State<IncomePassbookScreen>
    implements IncomePassbookView {
  IncomePassbookPresenter presenter = BasicIncomePassbookPresenter();
  late IncomePassbookModel model;
  final ScrollController _scrollController = ScrollController();
  String? filter;
  int page = 1;
  // String firstDate = "2020-04-01";
  // String lastDate = DateTime.now().getDateSecondFormat;
  String? fromDate;
  String? toDate;
  final List<String> _selectedItems = ["All"];
  final List<String> _options = [
    "All",
    "Prime A",
    "Prime B",
    "Booster",
    "Hybrid",
    "Repurchase",
    "Offer",
    "Royality"
  ];

  @override
  void initState() {
    super.initState();
    toDate = DateTime.now().getDateSecondFormat;
    presenter.updateView = this;
    // filter = widget.filter;
    _scrollController.addListener(_scrollListener);
    presenter.getIncomePassbook(
        page: page, filter: _selectedItems, context: context);
  }

  @override
  void refreshModel(IncomePassbookModel incomePassbookModel) {
    model = incomePassbookModel;
    if (mounted) {
      setState(() {});
    }
  }

  _scrollListener() {
    if ((_scrollController.position.maxScrollExtent / 2) ==
        ((_scrollController.position.pixels / 2))) {
      // if (model.lastPageIndex > page) {
      setState(() {
        page++;
      });
      presenter.getIncomePassbook(
          page: page,
          filter: _selectedItems,
          startDate: fromDate,
          endDate: toDate);
      // }
    }
  }

  // _scrollListener() {
  //   if (_scrollController.position.maxScrollExtent / 2 ==
  //       (_scrollController.offset) / 2) {
  //     setState(() {
  //       page++;
  //     });
  //     presenter.getIncomePassbook(
  //         page: page, startDate: fromDate, endDate: toDate);
  //   }
  // }

  Future<void> _refreshIndicator() async {
    presenter.getIncomePassbook(page: page, context: context);
  }

  // ScreenshotController screenshotController = ScreenshotController();

  String? userName;

  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  Circle progress = Circle();
  GlobalKey previewContainer = GlobalKey();

  _imageShare() async {
    progress.show(context);
    try {
      final RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/income_passbook.jpeg').create();
      await imagePath.writeAsBytes(pngBytes);
      await Share.shareXFiles([XFile(imagePath.path)]);
      // await ImageGallerySaver.saveImage(pngBytes);
      //        await Share.shareFiles([imagePath.path]);
      //   NetworkDio.showSuccess(
      //     title: AppConstString.success,
      //     context: context,
      //     sucessMessage: AppConstString.imageStored,
      //   );
    } catch (e) {}
    progress.hide(context);
    // try {
    //   pixelRatio = math.max(heightRatio, widthRatio);

    //   await screenshotController
    //       .capture(
    //           pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
    //       .then((image) async {
    //     if (image != null) {
    //       final directory = await getApplicationDocumentsDirectory();
    //       final imagePath = await File('${directory.path}/image.jpeg').create();
    //       await imagePath.writeAsBytes(image);
    //       await Share.shareFiles([imagePath.path]);
    //     }
    //   });
    // } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // controller: screenshotController,
      key: previewContainer,
      child: Scaffold(
          appBar: widget.isFromDrawer == true
              ? CustomAppBar(
                  title: 'Reward Passbook',
                  actions: [
                    InkWell(
                      onTap: () {
                        CommonMethod()
                            .getUserLog(action: 'Income_Passbook', id: 5);
                        _imageShare();
                      },
                      child: const Icon(Icons.share),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    PopupMenuButton<String>(
                      icon: Image.asset(
                        AppAssets.setting,
                        color: AppColors.whiteColor,
                        height: 20,
                        width: 20,
                      ),
                      onSelected: (value) {
                        setState(() {
                          if (_selectedItems.contains(value)) {
                            _selectedItems.remove(value);
                          } else {
                            _selectedItems.add(value);
                          }
                        });

                        presenter.getIncomePassbook(
                            page: 1,
                            startDate: fromDate,
                            filter: _selectedItems,
                            endDate: toDate,
                            context: context);
                      },
                      itemBuilder: (BuildContext context) {
                        return _options.map((String option) {
                          return PopupMenuItem<String>(
                            value: option,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(option),
                                StatefulBuilder(builder: (context, setstate) {
                                  return Checkbox(
                                    value: _selectedItems.contains(option),
                                    onChanged: (bool? selected) {
                                      setState(() {
                                        if (selected!) {
                                          _selectedItems.add(option);
                                        } else {
                                          _selectedItems.remove(option);
                                        }
                                      });
                                      setstate(() {});
                                      presenter.getIncomePassbook(
                                          page: 1,
                                          startDate: fromDate,
                                          filter: _selectedItems,
                                          endDate: toDate,
                                          context: context);
                                    },
                                  );
                                }),
                              ],
                            ),
                          );
                        }).toList();
                      },
                    )
                    // PopupMenuButton(
                    //   icon: Image.asset(
                    //     AppAssets.setting,
                    //     color: AppColors.whiteColor,
                    //     height: 20,
                    //     width: 20,
                    //   ),
                    //   onSelected: (value) {
                    //     model.incomeList = [];
                    //     if (value.toString() == "All") {
                    //       filter = null;
                    //       presenter.getIncomePassbook(
                    //           page: 1,
                    //           startDate: fromDate,
                    //           // filter: value.toString(),
                    //           endDate: toDate,
                    //           context: context);
                    //     } else {
                    //       filter = value;
                    //       presenter.getIncomePassbook(
                    //           page: 1,
                    //           startDate: fromDate,
                    //           filter: value.toString(),
                    //           endDate: toDate,
                    //           context: context);
                    //     }
                    //   },
                    //   itemBuilder: (BuildContext bc) {
                    //     return const [
                    //       PopupMenuItem(
                    //         value: 'All',
                    //         child: Text("All"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Prime A',
                    //         child: Text("Prime A"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Prime B',
                    //         child: Text("Prime B"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Booster',
                    //         child: Text("Booster"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Hybrid',
                    //         child: Text("Hybrid"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Repurchase',
                    //         child: Text("Repurchase"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Offer',
                    //         child: Text("Offer"),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Royality',
                    //         child: Text("Royality"),
                    //       ),
                    //     ];
                    //   },
                    // ),
                  ],
                )
              : null,
          body: Stack(
            children: [
              if (model.incomeList != null || model.incomeList!.isNotEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    model.incomeList!.length > 8 ? 'Data is loading...' : "",
                    style: AppTextStyle.semiBold16,
                  ),
                ),
              Column(
                children: [
                  if (widget.isFromDrawer == true)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: AppColors.containerbg,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            const Text(
                              'From',
                              textScaleFactor: 1.0,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => selectFromDate(context),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        fromDate != null
                                            ? fromDate.toString()
                                            : 'dd/mm/yyyy',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'To',
                              textScaleFactor: 1.0,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => selectToDate(context),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        toDate != null
                                            ? toDate.toString()
                                            : 'dd/mm/yyyy',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                model.incomeList = null;
                                if (fromDate != null && toDate != null) {
                                  presenter.getIncomePassbook(
                                      page: page,
                                      startDate: fromDate,
                                      filter: _selectedItems,
                                      endDate: toDate,
                                      context: context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.appColors,
                                    borderRadius: BorderRadius.circular(10)),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Text(
                                  'Show',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  if (model.totalAmount != null && widget.isFromDrawer == true)
                    Container(
                      decoration: CommonStyleDecoration.incomeBoxDecoration(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                model.totalAmount!.openingBalance.toString(),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    color: AppColors.secoundColors,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Opening',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                          ),
                          Column(
                            children: [
                              Text(
                                model.totalAmount!.totalCredit.toString(),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    color: AppColors.secoundColors,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Total Cr',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                          ),
                          Column(
                            children: [
                              Text(
                                model.totalAmount!.totalDebit.toString(),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    color: AppColors.secoundColors,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Total Dr',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                          ),
                          Column(
                            children: [
                              Text(
                                model.totalAmount!.balanceAmount.toString(),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    color: AppColors.secoundColors,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Total Balance',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (model.incomeList != null || model.incomeList!.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshIndicator,
                        child: ListView.builder(
                            itemCount: model.incomeList!.length,
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(6.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: CommonStyleDecoration
                                    .serviceBoxDecoration(),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order No #${model.incomeList![index].transactionId}',
                                            style: AppTextStyle.semiBold14,
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyyy hh:mm:ss")
                                                .parse(model.incomeList![index]
                                                    .incomeDate
                                                    .toString())
                                                .toString()
                                                .getDateTime,
                                            style: AppTextStyle.semiBold12
                                                .copyWith(
                                                    color: AppColors.greyColor),
                                          ),
                                          // if (model.incomeList![index]
                                          //         .senderMobile !=
                                          //     null)
                                          //   PopupMenuButton(
                                          //     padding: EdgeInsets.zero,
                                          //     iconSize: 20,
                                          //     icon: Image.asset(
                                          //       AppAssets.call,
                                          //       height: 20,
                                          //       width: 20,
                                          //     ),
                                          //     onSelected: (value) async {
                                          //       if ("WhatsApp" == value) {
                                          //         CommonMethod.whatsapp(
                                          //             mobileNumber: model
                                          //                 .incomeList![index]
                                          //                 .senderMobile
                                          //                 .toString());
                                          //       } else {
                                          //         await FlutterPhoneDirectCaller
                                          //             .callNumber(model
                                          //                 .incomeList![index]
                                          //                 .senderMobile
                                          //                 .toString());
                                          //       }
                                          //     },
                                          //     itemBuilder: (BuildContext bc) {
                                          //       return const [
                                          //         PopupMenuItem(
                                          //           value: 'WhatsApp',
                                          //           child: Text("WhatsApp"),
                                          //         ),
                                          //         PopupMenuItem(
                                          //           value: 'Phone',
                                          //           child: Text("Phone"),
                                          //         ),
                                          //       ];
                                          //     },
                                          //   ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Divider(
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.appLogo,
                                          height: 40,
                                          width: 40,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${model.incomeList![index].details}',
                                                      style: AppTextStyle
                                                          .regular14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${AppConstString.rupeesSymbol}${model.incomeList![index].type == "Credit" ? model.incomeList![index].credit : model.incomeList![index].debit}',
                                                    style: AppTextStyle.semiBold18.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: model
                                                                    .incomeList![
                                                                        index]
                                                                    .type
                                                                    .toString() ==
                                                                "Credit"
                                                            ? AppColors
                                                                .successColor
                                                            : AppColors
                                                                .errorColor),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    model
                                                        .incomeList![index].type
                                                        .toString(),
                                                    style: AppTextStyle.semiBold16.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: model
                                                                    .incomeList![
                                                                        index]
                                                                    .type
                                                                    .toString() ==
                                                                "Credit"
                                                            ? AppColors
                                                                .successColor
                                                            : AppColors
                                                                .errorColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'OB : ${AppConstString.rupeesSymbol}${model.incomeList![index].openingBalance}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: AppTextStyle
                                                          .semiBold14
                                                          .copyWith(
                                                        color:
                                                            AppColors.greyColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'CB : ${AppConstString.rupeesSymbol}${model.incomeList![index].closingBalance}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: AppTextStyle
                                                          .semiBold14
                                                          .copyWith(
                                                        color:
                                                            AppColors.greyColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    if (model.incomeList![index].isDropdown ==
                                            false &&
                                        model.incomeList![index].senderMobile !=
                                            null)
                                      InkWell(
                                          onTap: () {
                                            model.incomeList![index]
                                                .isDropdown = true;

                                            setState(() {});
                                          },
                                          child: const Icon(
                                              Icons.arrow_drop_down)),
                                    if (model.incomeList![index].isDropdown ==
                                        true)
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    if (model.incomeList![index].isDropdown ==
                                        true)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // CommonMethod().getUserLog(action: 'Call', id: 4);
                                              CommonMethod.whatsapp(
                                                mobileNumber: model
                                                    .incomeList![index]
                                                    .senderMobile
                                                    .toString(),
                                              );
                                              model.incomeList![index]
                                                  .isDropdown = false;
                                              setState(() {});
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AppAssets.whatsapp,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'WhatsApp',
                                                    style: AppTextStyle
                                                        .semiBold16
                                                        .copyWith(
                                                            color:
                                                                Colors.green),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(model
                                                      .incomeList![index]
                                                      .senderMobile
                                                      .toString());
                                              model.incomeList![index]
                                                  .isDropdown = false;
                                              setState(() {});
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AppAssets.phoneIcon,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Phone',
                                                    style: AppTextStyle
                                                        .semiBold16
                                                        .copyWith(
                                                            color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    // if (model.incomeList![index].senderMobile !=
                                    //     null)
                                    //   PopupMenuButton(
                                    //     padding: EdgeInsets.zero,
                                    //     icon: Image.asset(
                                    //       AppAssets.call,
                                    //       height: 20,
                                    //       width: 20,
                                    //     ),
                                    //     onSelected: (value) async {
                                    //       if ("WhatsApp" == value) {
                                    //         CommonMethod.whatsapp(
                                    //             mobileNumber: model
                                    //                 .incomeList![index]
                                    //                 .senderMobile
                                    //                 .toString());
                                    //       } else {
                                    //         await FlutterPhoneDirectCaller
                                    //             .callNumber(model
                                    //                 .incomeList![index]
                                    //                 .senderMobile
                                    //                 .toString());
                                    //       }
                                    //     },
                                    //     itemBuilder: (BuildContext bc) {
                                    //       return const [
                                    //         PopupMenuItem(
                                    //           value: 'WhatsApp',
                                    //           child: Text("WhatsApp"),
                                    //         ),
                                    //         PopupMenuItem(
                                    //           value: 'Phone',
                                    //           child: Text("Phone"),
                                    //         ),
                                    //       ];
                                    //     },
                                    //   ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  // if (model.incomeList == null || model.incomeList!.isEmpty)
                  //   Align(
                  //     alignment: Alignment.topCenter,
                  //     child: Text(
                  //       'No Data Found',
                  //       style: AppTextStyle.black16,
                  //     ),
                  //   )
                ],
              ),
            ],
          )),
    );
  }

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.getDateSecondFormat;
      });
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now(),
      selectableDayPredicate: (DateTime val) =>
          val.day == DateTime.now().day - 1 ? false : true,
    );

    if (picked != null) {
      setState(() {
        toDate = picked.getDateSecondFormat;
      });
    }
  }
}

class MultipleSelectionPopup extends StatefulWidget {
  const MultipleSelectionPopup({super.key});

  @override
  _MultipleSelectionPopupState createState() => _MultipleSelectionPopupState();
}

class _MultipleSelectionPopupState extends State<MultipleSelectionPopup> {
  final List<String> _selectedItems = [];
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PopupMenuButton<String>(
          onSelected: (String value) {},
          itemBuilder: (BuildContext context) {
            return _options.map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option),
                        Checkbox(
                          value: _selectedItems.contains(option),
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected!) {
                                _selectedItems.add(option);
                              } else {
                                _selectedItems.remove(option);
                              }
                            });
                            this.setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
