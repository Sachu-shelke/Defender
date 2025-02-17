import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_screen.dart';
import 'package:defenders/modules/refer/refer_screen.dart';
import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_screen.dart';
import 'package:defenders/modules/vendor/vendor_screen.dart';

class TodayTaskWidget extends StatelessWidget {
  final List graphicsList;
  const TodayTaskWidget({super.key, required this.graphicsList});

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
                AppConstString.todayTask.tr(),
                style: AppTextStyle.semiBold18,
              ),
              // Text(
              //   AppConstString.viewAll,
              //   style: AppTextStyle.semiBold14
              //       .copyWith(color: AppColors.appColors),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            // height: (graphicsList.length / 3) *
            //     (MediaQuery.of(context).size.height * 0.17),
            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: graphicsList.length > 12 ? 12 : graphicsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 6.0),
                itemBuilder: (context, index) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        if (index == 0 || index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TodayFollowUpScreen()));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const TodayCallScreen()));
                        } else if (index == 4 || index == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MarketingDashboardScreen(
                                isFromMainScreen: false,
                              ),
                            ),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VendorScreen(
                                url: 'https://bmrrmarketingservices.in/login',
                                isShowAppbar: "Whatsapp MSG",
                              ),
                            ),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReferScreen(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(msg: 'coming Soon');
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
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                graphicsList[index]['image'].toString(),
                                height: 40,
                                width: 40,
                                fit: BoxFit.fill,
                                // errorWidget: (context, url, error) =>
                                //     const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              graphicsList[index]['name'].toString(),
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
        )
      ],
    );
  }
}
