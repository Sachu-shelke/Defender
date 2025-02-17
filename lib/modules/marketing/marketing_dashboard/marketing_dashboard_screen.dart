// ignore_for_file: library_private_types_in_public_api, empty_catches, deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/graphics/new_graphics/new_get_graphics_categories_model.dart';
import 'package:defenders/model/graphics/new_graphics/new_get_graphics_modekl.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_model.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_presenter.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_view.dart';
import 'package:defenders/modules/marketing/marketing_share_screen.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_screen.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' show get;
import 'package:http/http.dart' as hhtp;
import 'package:share_plus/share_plus.dart';

class MarketingDashboardScreen extends StatefulWidget {
  final bool isFromMainScreen;
  const MarketingDashboardScreen({super.key, required this.isFromMainScreen});

  @override
  State<MarketingDashboardScreen> createState() =>
      _MarketingDashboardScreenState();
}

class _MarketingDashboardScreenState extends State<MarketingDashboardScreen>
    implements MarketingDashboardView {
  MarketingDashboardScreenPresenter presenter =
      BasicMarketingDashboardScreenPresenter();
  late MarketingDashboardModel model;
  final ScrollController _controller = ScrollController();
  bool isDetailsBenifits = true;
  bool isPosterView = true;
  int selectedIndex = 0;
  int brochureIndex = 0;
  String remotePDFpath = "";
  // NewGraphicsCategoryData? isGender;

  bool isOldView = false;

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.getCategoriesLeads(context: context, isGridView: isOldView);
  }

  @override
  void refreshModel(MarketingDashboardModel redeemModel) {
    model = redeemModel;
    if (mounted) {
      setState(() {});
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Marketing',
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const NotificationScreenRoute());
            },
            icon: const Icon(
              Icons.notifications,
              // color: AppColors.whiteColor,
            ),
          ),
          IconButton(
            onPressed: () {
              model.marketingCategories.clear();
              model.marketingSubCategories.clear();
              isOldView = !isOldView;
              isDetailsBenifits = true;
              isPosterView = true;
              presenter.getCategoriesLeads(
                  context: context, isGridView: isOldView);
              setState(() {});
              // context.router.push(const NotificationScreenRoute());
            },
            icon: Icon(
              isOldView == false ? Icons.grid_view : Icons.view_array_outlined,
              // color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      //  widget.isFromMainScreen == false
      //     ? const CustomAppBar(title: 'Marketing')
      //     : null,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: isOldView == false
              ? Column(
                  children: [
                    Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customTabBar(
                              title: 'Posters',
                              isSelected: isDetailsBenifits,
                              onTap: () {
                                isDetailsBenifits = !isDetailsBenifits;
                                setState(() {});
                              }),
                          customTabBar(
                              title: 'Brochure',
                              isSelected: !isDetailsBenifits,
                              onTap: () {
                                isDetailsBenifits = !isDetailsBenifits;

                                // launch(
                                //     'http://117.211.166.25:8082/jspui/bitstream/123456789/351/1/half%20girlfriend.pdf');
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                    if (isDetailsBenifits == true)
                      const SizedBox(
                        height: AppSizes.size10,
                      ),
                    if (isDetailsBenifits == true)
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.marketingCategories.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  selectedIndex = index;
                                  // final scrollindex = model.marketingSubCategories
                                  //     .indexOf(NewGetGraphicsData(
                                  //         graphicsDetailGroup: model
                                  //             .marketingCategories[selectedIndex]
                                  //             .category));
                                  final scrollindex = model
                                      .marketingSubCategories
                                      .indexWhere((element) =>
                                          element.graphicsDetailGroup ==
                                          model
                                              .marketingCategories[
                                                  selectedIndex]
                                              .category);
                                  if (scrollindex != -1) {
                                    _controller.animateTo(
                                      scrollindex *
                                          190.0, // Adjust this value as needed
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                  // presenter.getGraphics(
                                  //     context: context,
                                  //     catID:
                                  //         model.marketingCategories[index].id.toString());
                                  setState(() {});
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? AppColors.appColors
                                          : const Color(0xff3F3D3C),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    model.marketingCategories[index].category
                                        .toString(),
                                    style: AppTextStyle.semiBold14
                                        .copyWith(color: AppColors.whiteColor),
                                  ),
                                ),
                              );
                            }),
                      ),
                    if (isDetailsBenifits == true)
                      const SizedBox(
                        height: AppSizes.size10,
                      ),
                    if (isDetailsBenifits == true)
                      Expanded(
                        child: ListView.builder(
                            controller: _controller,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: model.marketingSubCategories.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        model.marketingSubCategories[index]
                                            .graphicsDetailGroup
                                            .toString(),
                                        style: AppTextStyle.semiBold16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // final scrollindex = model.marketingCategories
                                          //     .indexWhere((element) =>
                                          //         element.category ==
                                          //         model.marketingSubCategories[index]
                                          //             .graphicsDetailGroup);
                                          // if (scrollindex != -1) {
                                          //   _controller.animateTo(
                                          //     scrollindex *
                                          //         190.0, // Adjust this value as needed
                                          //     duration: const Duration(seconds: 1),
                                          //     curve: Curves.easeInOut,
                                          //   );
                                          // }
                                          if (model
                                              .marketingSubCategories[index]
                                              .graphics!
                                              .isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MarketingSubCatgoriesScreen(
                                                  categoriesID: model
                                                      .marketingSubCategories[
                                                          index]
                                                      .graphics!
                                                      .first
                                                      .category
                                                      .toString(),
                                                  categoriesName: model
                                                      .marketingSubCategories[
                                                          index]
                                                      .graphicsDetailGroup
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          'View All',
                                          style: AppTextStyle.semiBold14
                                              .copyWith(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppSizes.size6,
                                  ),
                                  if (model.marketingSubCategories[index]
                                          .graphics !=
                                      null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          model.marketingSubCategories[index]
                                              .graphics!.length,
                                          (ind) => marketingContainer(
                                              //Graphics
                                              data: model
                                                  .marketingSubCategories[index]
                                                  .graphics![ind]),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                      ),
                    if (isDetailsBenifits == true)
                      const SizedBox(
                        height: AppSizes.size10,
                      ),
                    if (isDetailsBenifits == false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              brochureIndex = 0;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: brochureIndex == 0
                                      ? AppColors.appColors
                                      : const Color(0xff3F3D3C),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(
                                'Hindi',
                                style: AppTextStyle.semiBold14
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              brochureIndex = 1;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                color: brochureIndex == 1
                                    ? AppColors.appColors
                                    : const Color(0xff3F3D3C),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'English',
                                style: AppTextStyle.semiBold14
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isDetailsBenifits == false)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: PDFScreen(
                          path: brochureIndex == 0
                              ? 'https://mirrorhub.in/MIRROR_NEW_PLAN_1_July_2024.pdf'
                              : 'https://mirrorhub.in/MIRROR_NEW_PLAN_1_July_2024.pdf',
                        ),
                      ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customTabBar(
                              title: 'Posters',
                              isSelected: isPosterView,
                              onTap: () {
                                isPosterView = !isPosterView;
                                setState(() {});
                              }),
                          customTabBar(
                              title: 'Daily Feed',
                              isSelected: !isPosterView,
                              onTap: () {
                                isPosterView = !isPosterView;

                                // launch(
                                //     'http://117.211.166.25:8082/jspui/bitstream/123456789/351/1/half%20girlfriend.pdf');
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                    if (isPosterView == false) Container(),
                    if (isPosterView == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 170,
                              child: DropdownButtonFormField<
                                  NewGraphicsCategoryData>(
                                focusColor: AppColors.appColors,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                value: model.isSelectedValue,
                                hint: Text(
                                  model.isSelectedValue == null
                                      ? 'Select your Category'
                                      : model.isSelectedValue!.category
                                          .toString(),
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                isExpanded: true,
                                onChanged: (value) {
                                  model.isSelectedValue = value!;
                                  presenter.getGraphics(
                                      catID: value.id.toString(),
                                      context: context,
                                      isGridView: isOldView);
                                  setState(() {});
                                },
                                validator: (value) => value == null
                                    ? 'This field required'
                                    : null,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.appColors,
                                  size: 24,
                                ),
                                iconSize: 24,
                                items: model.marketingCategories
                                    .map<
                                            DropdownMenuItem<
                                                NewGraphicsCategoryData>>(
                                        (NewGraphicsCategoryData value) {
                                      return DropdownMenuItem<
                                          NewGraphicsCategoryData>(
                                        value: value,
                                        child: Text(
                                          value.category.toString(),
                                          textScaleFactor: 1.0,
                                          style: AppTextStyle.regular16,
                                        ),
                                      );
                                    })
                                    .toSet()
                                    .toList(),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MarketingSubCatgoriesScreen(
                                    categoriesID:
                                        model.isSelectedValue!.id.toString(),
                                    categoriesName: model
                                        .isSelectedValue!.category
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "View All",
                              style: AppTextStyle.semiBold16
                                  .copyWith(color: AppColors.appColors),
                            ),
                          )
                        ],
                      ),
                    if (isPosterView == true &&
                        model.marketingSubCategories.isNotEmpty &&
                        model.marketingSubCategories[0].graphics != null)
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              model.marketingSubCategories[0].graphics!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GraphicsShareScreen(
                                              isImageUrlFull: true,
                                              categoriesImage: model
                                                  .marketingSubCategories[0]
                                                  .graphics![index]
                                                  .image
                                                  .toString(),
                                              categoriesName: model
                                                  .marketingSubCategories[0]
                                                  .graphics![index]
                                                  .graphicsName
                                                  .toString(),
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                // border: Border.all(color: AppColors.appColors),
                                decoration: BoxDecoration(
                                  // color: AppColors.appColors.withOpacity(0.1),
                                  border: Border.all(
                                    color: AppColors.appColors,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                      // width: 160,
                                      constraints: const BoxConstraints(
                                        minHeight: 400.0,
                                      ),
                                      child: CachedNetworkImage(
                                        // width: 160,
                                        // height: 170,
                                        imageUrl:
                                            "${model.marketingSubCategories[0].graphics![index].image}",
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Icon(Icons.error)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 10, vertical: 5),
                                    //   decoration: const BoxDecoration(
                                    //     color: AppColors.secoundColors,
                                    //   ),
                                    //   child: Text(
                                    //     model.marketingSubCategories[0]
                                    //         .graphics![index].graphicsName
                                    //         .toString(),
                                    //     textAlign: TextAlign.center,
                                    //     style: const TextStyle(
                                    //         fontSize: 16,
                                    //         fontWeight: FontWeight.w600,
                                    //         color: AppColors.whiteColor),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 4,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     InkWell(
                                    //         onTap: () {
                                    //           // _share(
                                    //           //   widget.graphicsCategoriesList[index].imageurl
                                    //           //       .toString(),
                                    //           // );

                                    //           // BlocProvider.of<HomeCubit>(context)
                                    //           //     .updateShareGraphics(
                                    //           //         graphicsId: widget
                                    //           //             .graphicsCategoriesList[index].graphicsId
                                    //           //             .toString(),
                                    //           //         shareCount: (int.parse(widget
                                    //           //                 .graphicsCategoriesList[index]
                                    //           //                 .shareCount
                                    //           //                 .toString()))
                                    //           //             .toString());
                                    //           // widget.graphicsCategoriesList[index].shareCount =
                                    //           //     (int.parse(widget.graphicsCategoriesList[index]
                                    //           //                 .shareCount
                                    //           //                 .toString()) +
                                    //           //             1)
                                    //           //         .toString();

                                    //           model
                                    //               .marketingSubCategories[0]
                                    //               .graphics![index]
                                    //               .shareCount = ((model
                                    //                       .marketingSubCategories[
                                    //                           0]
                                    //                       .graphics![index]
                                    //                       .shareCount ??
                                    //                   0) +
                                    //               1);
                                    //           presenter.updateLike(
                                    //               id: model
                                    //                   .marketingSubCategories[0]
                                    //                   .graphics![index]
                                    //                   .id
                                    //                   .toString(),
                                    //               action: 'Share');
                                    //           setState(() {});
                                    //         },
                                    //         child: const Icon(Icons.share)),
                                    //     const SizedBox(
                                    //       width: 5,
                                    //     ),
                                    //     Text(
                                    //       model.marketingSubCategories[0]
                                    //           .graphics![index].shareCount
                                    //           .toString(),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     InkWell(
                                    //         onTap: () {
                                    //           // BlocProvider.of<HomeCubit>(context)
                                    //           //     .updateLikeGraphics(
                                    //           //         graphicsId: widget
                                    //           //             .graphicsCategoriesList[index].graphicsId
                                    //           //             .toString(),
                                    //           //         likeCount: widget
                                    //           //             .graphicsCategoriesList[index].likeCount
                                    //           //             .toString());

                                    //           model
                                    //               .marketingSubCategories[0]
                                    //               .graphics![index]
                                    //               .likeCount = ((model
                                    //                       .marketingSubCategories[
                                    //                           0]
                                    //                       .graphics![index]
                                    //                       .likeCount ??
                                    //                   0) +
                                    //               1);
                                    //           presenter.updateLike(
                                    //               id: model
                                    //                   .marketingSubCategories[0]
                                    //                   .graphics![index]
                                    //                   .id
                                    //                   .toString(),
                                    //               action: 'Like');
                                    //           setState(() {});
                                    //         },
                                    //         child: const Icon(Icons.favorite)),
                                    //     const SizedBox(
                                    //       width: 5,
                                    //     ),
                                    //     Text(
                                    //       model.marketingSubCategories[0]
                                    //           .graphics![index].likeCount
                                    //           .toString(),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (isPosterView == false && model.todaysStatus.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GraphicsShareScreen(
                                        isImageUrlFull: true,
                                        categoriesImage:
                                            "https://secure.mirror.org.in/${model.todaysStatus.first.image}",
                                        categoriesName: "Today Status",
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          // border: Border.all(color: AppColors.appColors),
                          decoration: BoxDecoration(
                            // color: AppColors.appColors.withOpacity(0.1),
                            border: Border.all(
                              color: AppColors.appColors,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                // width: 160,
                                constraints: const BoxConstraints(
                                  minHeight: 400.0,
                                ),
                                child: CachedNetworkImage(
                                  // width: 160,
                                  // height: 170,
                                  imageUrl:
                                      "https://secure.mirror.org.in/${model.todaysStatus.first.image}",
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 10, vertical: 5),
                              //   decoration: const BoxDecoration(
                              //     color: AppColors.secoundColors,
                              //   ),
                              //   child: Text(
                              //     model.marketingSubCategories[0]
                              //         .graphics![index].graphicsName
                              //         .toString(),
                              //     textAlign: TextAlign.center,
                              //     style: const TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w600,
                              //         color: AppColors.whiteColor),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 4,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.center,
                              //   children: [
                              //     InkWell(
                              //         onTap: () {
                              //           // _share(
                              //           //   widget.graphicsCategoriesList[index].imageurl
                              //           //       .toString(),
                              //           // );

                              //           // BlocProvider.of<HomeCubit>(context)
                              //           //     .updateShareGraphics(
                              //           //         graphicsId: widget
                              //           //             .graphicsCategoriesList[index].graphicsId
                              //           //             .toString(),
                              //           //         shareCount: (int.parse(widget
                              //           //                 .graphicsCategoriesList[index]
                              //           //                 .shareCount
                              //           //                 .toString()))
                              //           //             .toString());
                              //           // widget.graphicsCategoriesList[index].shareCount =
                              //           //     (int.parse(widget.graphicsCategoriesList[index]
                              //           //                 .shareCount
                              //           //                 .toString()) +
                              //           //             1)
                              //           //         .toString();

                              //           model
                              //               .marketingSubCategories[0]
                              //               .graphics![index]
                              //               .shareCount = ((model
                              //                       .marketingSubCategories[
                              //                           0]
                              //                       .graphics![index]
                              //                       .shareCount ??
                              //                   0) +
                              //               1);
                              //           presenter.updateLike(
                              //               id: model
                              //                   .marketingSubCategories[0]
                              //                   .graphics![index]
                              //                   .id
                              //                   .toString(),
                              //               action: 'Share');
                              //           setState(() {});
                              //         },
                              //         child: const Icon(Icons.share)),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Text(
                              //       model.marketingSubCategories[0]
                              //           .graphics![index].shareCount
                              //           .toString(),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     InkWell(
                              //         onTap: () {
                              //           // BlocProvider.of<HomeCubit>(context)
                              //           //     .updateLikeGraphics(
                              //           //         graphicsId: widget
                              //           //             .graphicsCategoriesList[index].graphicsId
                              //           //             .toString(),
                              //           //         likeCount: widget
                              //           //             .graphicsCategoriesList[index].likeCount
                              //           //             .toString());

                              //           model
                              //               .marketingSubCategories[0]
                              //               .graphics![index]
                              //               .likeCount = ((model
                              //                       .marketingSubCategories[
                              //                           0]
                              //                       .graphics![index]
                              //                       .likeCount ??
                              //                   0) +
                              //               1);
                              //           presenter.updateLike(
                              //               id: model
                              //                   .marketingSubCategories[0]
                              //                   .graphics![index]
                              //                   .id
                              //                   .toString(),
                              //               action: 'Like');
                              //           setState(() {});
                              //         },
                              //         child: const Icon(Icons.favorite)),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Text(
                              //       model.marketingSubCategories[0]
                              //           .graphics![index].likeCount
                              //           .toString(),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),

                    // DropdownButtonHideUnderline(
                    //   child: DropdownButtonFormField<String>(
                    //     isDense: false,
                    //     items: model.marketingCategories
                    //         .map<DropdownMenuItem<String>>(
                    //             (NewGraphicsCategoryData value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value.id.toString(),
                    //             child: Text(
                    //               value.category.toString(),
                    //               textScaleFactor: 1.0,
                    //               style: const TextStyle(fontSize: 16),
                    //             ),
                    //           );
                    //         })
                    //         .toSet()
                    //         .toList(),
                    //     onChanged: (value) {
                    //       isGender = value!;
                    //       setState(() {});
                    //     },
                    //     decoration: const InputDecoration(
                    //         fillColor: AppColors.whiteColor,
                    //         // fillColor: Appc,
                    //         filled: true,
                    //         contentPadding: EdgeInsets.symmetric(
                    //             horizontal: 16, vertical: 5),
                    //         border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20)),
                    //           borderSide: BorderSide(width: 1.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20)),
                    //           borderSide: BorderSide(width: 1.0),
                    //         )),
                    //     hint: Text(
                    //       'Select your Gender',
                    //       textScaleFactor: 1.0,
                    //       style: TextStyle(color: Colors.grey.shade800),
                    //     ),
                    //     isExpanded: true,
                    //     validator: (value) =>
                    //         value == null ? 'This field required' : null,
                    //     icon: const Icon(
                    //       Icons.arrow_drop_down,
                    //       size: 30,
                    //     ),
                    //     iconSize: 24,
                    //   ),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: PopupMenuButton(
                    //     // child: const Text("Category"),
                    //     icon: const Text('Filters'),
                    //     padding: EdgeInsets.zero,
                    //     // icon: const Icon(Icons.arrow_drop_down),
                    //     enabled: true,
                    //     onSelected: (value) {
                    //       // model.incomeList = [];
                    //       // if (value.toString() == "All") {
                    //       //   filter = null;
                    //       //   presenter.getIncomePassbook(
                    //       //       page: 1,
                    //       //       startDate: fromDate,
                    //       //       // filter: value.toString(),
                    //       //       endDate: toDate,
                    //       //       context: context);
                    //       // } else {
                    //       //   filter = value;
                    //       //   presenter.getIncomePassbook(
                    //       //       page: 1,
                    //       //       startDate: fromDate,
                    //       //       filter: value.toString(),
                    //       //       endDate: toDate,
                    //       //       context: context);
                    //       // }
                    //     },

                    //     itemBuilder: (BuildContext bc) {
                    //       return List.generate(
                    //         model.marketingCategories.length,
                    //         (index) => PopupMenuItem(
                    //           value: model.marketingCategories[index].id,
                    //           child: Text(model
                    //               .marketingCategories[index].category
                    //               .toString()),
                    //         ),
                    //       );
                    //       //  [
                    //       //   PopupMenuItem(
                    //       //     value: 'All',
                    //       //     child: Text("All"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Prime A',
                    //       //     child: Text("Prime A"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Prime B',
                    //       //     child: Text("Prime B"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Booster',
                    //       //     child: Text("Booster"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Hybrid',
                    //       //     child: Text("Hybrid"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Repurchase',
                    //       //     child: Text("Repurchase"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Offer',
                    //       //     child: Text("Offer"),
                    //       //   ),
                    //       //   PopupMenuItem(
                    //       //     value: 'Royality',
                    //       //     child: Text("Royality"),
                    //       //   ),
                    //       // ];
                    //     },
                    //   ),
                    // ),
                  ],
                )),

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         GradientText(
      //           "Hi ${greeting()}",
      //           style: AppTextStyle.semiBold18,
      //           gradient: const LinearGradient(colors: [
      //             Color(0xff101A33),
      //             Color(0xff618DEC),
      //           ]),
      //         ),
      //         GradientText(
      //           "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
      //           style: AppTextStyle.semiBold26,
      //           gradient: const LinearGradient(colors: [
      //             Color(0xff101A33),
      //             Color(0xff618DEC),
      //           ]),
      //         ),
      //         // Text(
      //         //   'Hi ${greeting()}',
      //         //   style:
      //         //       const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //         // ),
      //         // const SizedBox(
      //         //   height: 5,
      //         // ),
      //         // Text(
      //         //   '${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}',
      //         //   style:
      //         //       const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      //         // ),
      //         const SizedBox(
      //           height: 8,
      //         ),
      //         const Text(
      //           'What do you want to do today?',
      //           textScaleFactor: 1.0,
      //           style: TextStyle(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w400,
      //               color: Color(0xff636363)),
      //         ),
      //         const SizedBox(
      //           height: 8,
      //         ),
      //         // const Text(
      //         //   'Posters of the day',
      //         //   textScaleFactor: 1.0,
      //         //   style: TextStyle(
      //         //     fontSize: 20,
      //         //     fontWeight: FontWeight.w600,
      //         //   ),
      //         // ),
      //         // const SizedBox(
      //         //   height: 8,
      //         // ),
      //         Text(
      //           DateFormat.yMMMMd().format(DateTime.now()).toString(),
      //           style: const TextStyle(fontSize: 16, color: Color(0xff636363)),
      //         ),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         if (model.graphicsdata.todaysStatus != null &&
      //             model.graphicsdata.todaysStatus!.isNotEmpty)
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 AppConstString.todayStatus.tr(),
      //                 style: AppTextStyle.semiBold16,
      //               ),
      //             ],
      //           ),
      //         const SizedBox(
      //           height: AppSizes.size6,
      //         ),
      //         if (model.graphicsdata.todaysStatus != null &&
      //             model.graphicsdata.todaysStatus!.isNotEmpty)
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 50),
      //             child: CarouselSlider.builder(
      //                 itemCount: model.graphicsdata.todaysStatus!.length,
      //                 itemBuilder: (BuildContext context, int itemIndex,
      //                     int pageViewIndex) {
      //                   return InkWell(
      //                     onTap: () {},
      //                     child: ClipRRect(
      //                       borderRadius: BorderRadius.circular(10),
      //                       child: Image.network(
      //                           'https://secure.mirror.org.in/${model.graphicsdata.todaysStatus![itemIndex].image}'),
      //                     ),
      //                   );
      //                 },
      //                 options: CommonMethod.carouselOptions(size: 160)),
      //           ),
      //         const Text(
      //           'Marketing Tool',
      //           textScaleFactor: 1.0,
      //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      //         ),
      //         if (model.graphicsdata.data != null)
      //           SizedBox(
      //             height: double.parse(
      //                     (model.graphicsdata.data!.length / 3).toString()) *
      //                 125,
      //             child: GridView.builder(
      //                 physics: const NeverScrollableScrollPhysics(),
      //                 itemCount: model.graphicsdata.data!.length,
      //                 gridDelegate:
      //                     const SliverGridDelegateWithFixedCrossAxisCount(
      //                         crossAxisCount: 3),
      //                 itemBuilder: (context, index) {
      //                   return model.graphicsdata.data![index].category ==
      //                           'Daily update'
      //                       ? const SizedBox()
      //                       : InkWell(
      //                           onTap: () {
      //                             Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                 builder: (context) =>
      //                                     MarketingSubCatgoriesScreen(
      //                                   categoriesID: model
      //                                       .graphicsdata.data![index].id
      //                                       .toString(),
      //                                   categoriesName: model
      //                                       .graphicsdata.data![index].category
      //                                       .toString(),
      //                                 ),
      //                               ),
      //                             );
      //                           },
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             children: [
      //                               CachedNetworkImage(
      //                                 height: 50,
      //                                 width: 50,
      //                                 imageUrl: model
      //                                     .graphicsdata.data![index].image
      //                                     .toString(),
      //                                 fit: BoxFit.fill,
      //                                 errorWidget: (context, url, error) =>
      //                                     const Icon(Icons.error),
      //                               ),
      //                               const SizedBox(
      //                                 height: 8,
      //                               ),
      //                               Text(
      //                                 model.graphicsdata.data![index].category
      //                                     .toString(),
      //                                 textAlign: TextAlign.center,
      //                               )
      //                             ],
      //                           ),
      //                         );
      //                 }),
      //           )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  _share(imageUrl) async {
    var url = imageUrl.toString();
    var response = await get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    await Share.shareXFiles([XFile(filePathAndName)]);
  }

  Widget marketingContainer({required Graphics data}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GraphicsShareScreen(
              isImageUrlFull: true,
              categoriesImage: data.image.toString(),
              categoriesName: data.graphicsName.toString(),
            ),
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MarketingPreviewScreen(
        //       data: data,
        //     ),
        //   ),
        // );
      },
      child: Container(
        height: 175,
        width: 130,

        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.appColors.withOpacity(0.1),
          border: Border.all(
            color: AppColors.appColors,
          ),
          // boxShadow: [
          //   BoxShadow(
          //       blurRadius: 2,
          //       offset: const Offset(1, 2),
          //       color: AppColors.greyColor.withOpacity(0.4),
          //       spreadRadius: 1)
          // ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     // border: Border.all(color: AppColors.whiteColor),
        //     boxShadow: [
        //       BoxShadow(
        //           blurRadius: 2,
        //           offset: const Offset(1, 2),
        //           color: AppColors.greyColor.withOpacity(0.4),
        //           spreadRadius: 1)
        //     ],
        //     color: AppColors.secoundColors),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  data.image.toString(),
                  height: 120,
                  width: 130,
                  fit: BoxFit.cover,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      _share(
                        data.image.toString(),
                      );

                      // BlocProvider.of<HomeCubit>(context)
                      //     .updateShareGraphics(
                      //         graphicsId: widget
                      //             .graphicsCategoriesList[index].graphicsId
                      //             .toString(),
                      //         shareCount: (int.parse(widget
                      //                 .graphicsCategoriesList[index]
                      //                 .shareCount
                      //                 .toString()))
                      //             .toString());
                      // widget.graphicsCategoriesList[index].shareCount =
                      //     (int.parse(widget.graphicsCategoriesList[index]
                      //                 .shareCount
                      //                 .toString()) +
                      //             1)
                      //         .toString();
                      CommonMethod()
                          .getUserLog(action: 'Marketing_Grafix', id: 6);
                      data.shareCount = ((data.shareCount ?? 0) + 1);
                      presenter.updateLike(
                          id: data.id.toString(), action: 'Share');
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.share,
                      size: 20,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  data.shareCount.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      if (data.isLike == 1) {
                        data.isLike = 0;
                        data.likeCount = data.likeCount! - 1;
                      } else {
                        data.isLike = 1;
                        data.likeCount = data.likeCount! + 1;
                      }
                      // data.likeCount = ((data.likeCount ?? 0) + 1);
                      presenter.updateLike(
                          id: data.id.toString(), action: 'Like');
                      setState(() {});
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: data.isLike == 1
                          ? AppColors.errorColor
                          : AppColors.greyColor,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  data.likeCount.toString(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> downloadAndSaveImage(String imageUrl) async {
    try {
      // Request storage permission
      // if (status.isGranted) {
      final hhtp.Response response = await get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Get the Downloads directory
        Directory? downloadsDirectory = await getDownloadsDirectory();
        String filePath = '${downloadsDirectory!.path}/image.jpg';

        // Save the image to the Downloads directory
        File file = File(filePath);
        await file.writeAsBytes(bytes);

        Fluttertoast.showToast(msg: 'Image Download');
      } else {}
      // } else {
      //   print('Permission denied');
      // }
    } catch (e) {}
  }

  Widget customTabBar({
    required String title,
    required bool isSelected,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 3.0,
                color: isSelected == true
                    ? AppColors.appColors
                    : Colors.transparent),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.semiBold16.copyWith(
              color: isSelected == true
                  ? AppColors.appColors
                  : AppColors.blackColor),
        ),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String path;

  const PDFScreen({super.key, required this.path});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.75,
                width: MediaQuery.of(context).size.width,
                child: PDF(
                  fitPolicy: FitPolicy.BOTH,
                  fitEachPage: true,
                  preventLinkNavigation: true,
                  enableSwipe: true,
                  onViewCreated: (PDFViewController pdfViewController) async {
                    _pdfViewController.complete(pdfViewController);
                  },
                ).fromUrl(
                  widget.path.toString(),
                  placeholder: (double progress) => Center(
                      child: Text(
                    '$progress %',
                    textScaleFactor: 1.0,
                  )),
                  errorWidget: (dynamic error) => Center(
                      child: Text(
                    error.toString(),
                    textScaleFactor: 1.0,
                  )),
                )),
            // errorMessage.isEmpty
            //     ? !isReady
            //         ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : Container()
            //     : Center(
            //         child: Text(errorMessage),
            //       )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                text: 'Share',
                onTap: () async {
                  // File? x = await sharePdf(
                  //   url: widget.magazineModel.fileUrl,
                  //   fileName: widget.magazineModel.name,
                  // );
                  CommonMethod().getUserLog(action: 'pdf', id: 10);
                  _sharePdf(widget.path);
                },
              )),
              const SizedBox(
                width: AppSizes.size10,
              ),
              Expanded(
                  child: PrimaryButton(
                      onTap: () {
                        downloadAndSaveImage(widget.path);

                        // downloadAndSaveImage(widget.data.image.toString());
                      },
                      text: 'Download'))
            ],
          ),
        ),
      ],
    );
    // floatingActionButton: FutureBuilder<PDFViewController>(
    //   future: _controller.future,
    //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
    //     if (snapshot.hasData) {
    //       return FloatingActionButton.extended(
    //         label: Text("Go to ${pages! ~/ 2}"),
    //         onPressed: () async {
    //           await snapshot.data!.setPage(pages! ~/ 2);
    //         },
    //       );
    //     }

    //     return Container();
    //   },
    // ),
    // );
  }

  // _share(imageUrl) async {
  //   var url = imageUrl.toString();
  //   var response = await get(Uri.parse(url));
  //   var documentDirectory = await getApplicationDocumentsDirectory();
  //   var firstPath = "${documentDirectory.path}/image";
  //   var filePathAndName = '${documentDirectory.path}/image/company.jpg';
  //   await Directory(firstPath).create(recursive: true);
  //   File file2 = File(filePathAndName);
  //   file2.writeAsBytesSync(response.bodyBytes);
  //   await Share.shareFiles([filePathAndName]);
  // }

  _sharePdf(imageUrl) async {
    var url = imageUrl.toString();
    var response = await get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/pdf";
    var filePathAndName = '${documentDirectory.path}/pdf/company.pdf';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    await Share.shareXFiles([XFile(filePathAndName)]);
  }

  Future<void> downloadAndSaveImage(String imageUrl) async {
    try {
      // Request storage permission
      // if (status.isGranted) {
      final hhtp.Response response = await get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Get the Downloads directory
        Directory? downloadsDirectory = await getDownloadsDirectory();
        String filePath = '${downloadsDirectory!.path}/image.jpg';

        // Save the image to the Downloads directory
        File file = File(filePath);
        await file.writeAsBytes(bytes);

        Fluttertoast.showToast(msg: 'PDF Download');
      } else {}
      // } else {
      //   print('Permission denied');
      // }
    } catch (e) {}
  }
}
