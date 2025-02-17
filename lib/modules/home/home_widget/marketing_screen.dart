import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/model/graphics/get_graphics_model.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_screen.dart';
import 'package:defenders/modules/marketing/marketing_sub_categories/marketing_sub_categories_screen.dart';

class MarketingWidget extends StatelessWidget {
  final List<GraphicsCategoryData> graphicsList;
  final bool isTodayTask;
  const MarketingWidget(
      {super.key, required this.isTodayTask, required this.graphicsList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isTodayTask == true
                    ? AppConstString.todayTask.tr()
                    : AppConstString.marketing.tr(),
                style: AppTextStyle.semiBold18,
              ),
              // InkWell(
              //   onTap: () {
              //     if (isTodayTask == true) {
              //       Fluttertoast.showToast(msg: 'Coming Soon');
              //     } else {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const MarketingDashboardScreen(),
              //         ),
              //       );
              //     }
              //   },
              //   child: Text(
              //     AppConstString.viewAll,
              //     style: AppTextStyle.semiBold14
              //         .copyWith(color: AppColors.appColors),
              //   ),
              // ),
            ],
          ),
        ),
        // GridView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: model.graphicsdata.length,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3),
        //     itemBuilder: (context, index) {
        //       return model.graphicsdata[index].category == 'Daily update'
        //           ? const SizedBox()
        //           : InkWell(
        //               onTap: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => MarketingSubCatgoriesScreen(
        //                       categoriesID:
        //                           model.graphicsdata[index].id.toString(),
        //                       categoriesName:
        //                           model.graphicsdata[index].category.toString(),
        //                     ),
        //                   ),
        //                 );
        //               },
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   CachedNetworkImage(
        //                     height: 50,
        //                     width: 50,
        //                     imageUrl:
        //                         model.graphicsdata[index].image.toString(),
        //                     fit: BoxFit.fill,
        //                     errorWidget: (context, url, error) =>
        //                         const Icon(Icons.error),
        //                   ),
        //                   const SizedBox(
        //                     height: 8,
        //                   ),
        //                   Text(
        //                     model.graphicsdata[index].category.toString(),
        //                     textAlign: TextAlign.center,
        //                   )
        //                 ],
        //               ),
        //             );
        //     }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            // height: ((graphicsList.length > 8 ? 8 : graphicsList.length) / 4) *
            //     (MediaQuery.of(context).size.height * 0.13),
            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: graphicsList.length > 8 ? 8 : graphicsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.97,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 6.0),
                itemBuilder: (context, index) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        // Fluttertoast.showToast(msg: 'Comming Soon');
                        if (isTodayTask == true) {
                          Fluttertoast.showToast(msg: 'Coming Soon');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketingSubCatgoriesScreen(
                                categoriesID: graphicsList[index].id.toString(),
                                categoriesName:
                                    graphicsList[index].category.toString(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.borderGreyColor),
                          color: AppColors.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 70,
                                imageUrl: graphicsList[index].image.toString(),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              graphicsList[index].category.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),

        InkWell(
          onTap: () {
            if (isTodayTask == true) {
              Fluttertoast.showToast(msg: 'Coming Soon');
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarketingDashboardScreen(
                    isFromMainScreen: false,
                  ),
                ),
              );
            }
          },
          child: Text(
            AppConstString.viewAll,
            style: AppTextStyle.semiBold14.copyWith(color: AppColors.appColors),
          ),
        ),
      ],
    );
  }
}
