import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/modules/marketing/marketing_share_screen.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_model.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_presenter.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class MarketingSubCatgoriesScreen extends StatefulWidget {
  final String categoriesID;
  final String categoriesName;
  const MarketingSubCatgoriesScreen({
    super.key,
    required this.categoriesID,
    required this.categoriesName,
  });

  @override
  State<MarketingSubCatgoriesScreen> createState() =>
      _MarketingSubCatgoriesScreenState();
}

class _MarketingSubCatgoriesScreenState
    extends State<MarketingSubCatgoriesScreen>
    implements MarketingSubCategoriesView {
  MarketingSubCategoriesPresenter presenter =
      BasicMarketingSubCategoriesPresenter();
  late MarketingSubCategoriesModel model;
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    _scrollController.addListener(_scrollListener);
    presenter.getGraphics(
        page: page, context: context, catId: widget.categoriesID);
  }

  _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        (_scrollController.offset)) {
      setState(() {
        page++;
      });
      presenter.getGraphics(page: page, catId: widget.categoriesID);
    }
  }

  @override
  void refreshModel(MarketingSubCategoriesModel redeemModel) {
    model = redeemModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoriesName.toString(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.builder(
          itemCount: model.graphicsdata.length,
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GraphicsShareScreen(
                              isImageUrlFull: false,
                              categoriesImage:
                                  model.graphicsdata[index].image.toString(),
                              categoriesName: widget.categoriesName,
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
                    SizedBox(
                      width: 160,
                      height: 170,
                      child: CachedNetworkImage(
                        width: 160,
                        height: 170,
                        imageUrl:
                            "https://secure.mirror.org.in/${model.graphicsdata[index].image}",
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: AppColors.secoundColors,
                      ),
                      child: Text(
                        model.graphicsdata[index].graphicsName.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              // _share(
                              //   widget.graphicsCategoriesList[index].imageurl
                              //       .toString(),
                              // );

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

                              model.graphicsdata[index].shareCount =
                                  ((model.graphicsdata[index].shareCount ?? 0) +
                                      1);
                              presenter.updateLike(
                                  id: model.graphicsdata[index].id.toString(),
                                  action: 'Share');
                              setState(() {});
                            },
                            child: const Icon(Icons.share)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.graphicsdata[index].shareCount.toString(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              // BlocProvider.of<HomeCubit>(context)
                              //     .updateLikeGraphics(
                              //         graphicsId: widget
                              //             .graphicsCategoriesList[index].graphicsId
                              //             .toString(),
                              //         likeCount: widget
                              //             .graphicsCategoriesList[index].likeCount
                              //             .toString());

                              model.graphicsdata[index].likeCount =
                                  ((model.graphicsdata[index].likeCount ?? 0) +
                                      1);
                              presenter.updateLike(
                                  id: model.graphicsdata[index].id.toString(),
                                  action: 'Like');
                              setState(() {});
                            },
                            child: const Icon(Icons.favorite)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.graphicsdata[index].likeCount.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
