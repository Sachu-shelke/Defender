import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_model.dart';
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_presenter.dart';
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

@RoutePage()
class PrimeDashboardScreen extends StatefulWidget {
  final bool isFromEpin;
  final String? userId;
  const PrimeDashboardScreen({
    super.key,
    required this.isFromEpin,
    this.userId,
  });

  @override
  State<PrimeDashboardScreen> createState() => _PrimeDashboardScreenState();
}

class _PrimeDashboardScreenState extends State<PrimeDashboardScreen>
    implements PrimeDashboardView {
  late PrimeDashboardModel model;

  PrimeDashboardPresenter presenter = BasicPrimeDashboardPresenter();

  @override
  void initState() {
    presenter.updateView = this;
    presenter.getPrimePlanDetails(context: context);
    super.initState();
  }

  @override
  void refreshModel(PrimeDashboardModel primeDashboardModel) {
    model = primeDashboardModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Prime Purchase'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider(
            items: List.generate(
                model.primeList.length,
                (index) => PrimesPlan(
                      index: index,
                      planName: model.primeList[index].planName.toString(),
                      featuresList:
                          model.primeList[index].planDetails!.toList(),
                      gst: model.primeList[index].gst.toString(),
                      onTap: () {
                        context.router.push(PrimePlanPurchaseScreenRoute(
                            isFromEpin: widget.isFromEpin,
                            userId: widget.userId,
                            data: model.primeList[index]));
                      },
                      planAmountWithoutGst: double.parse(
                              model.primeList[index].withoutGst.toString())
                          .round()
                          .toString(),
                      planamount: double.parse(
                              model.primeList[index].planAmount.toString())
                          .round()
                          .toString(),
                      recomanded: false,
                    )),
            options: CarouselOptions(
              height: 680,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 3500),
              viewportFraction: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}

class PrimesPlan extends StatelessWidget {
  final int index;
  final String planamount;
  final String planName;
  final String planAmountWithoutGst;
  final String gst;
  final VoidCallback onTap;
  final bool? recomanded;
  final List<String> featuresList;
  const PrimesPlan(
      {super.key,
      required this.planamount,
      required this.index,
      required this.planName,
      required this.planAmountWithoutGst,
      required this.gst,
      required this.featuresList,
      required this.onTap,
      this.recomanded});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: index == 0
                ? AppColors.blue.withOpacity(0.2)
                : index == 1
                    ? AppColors.secoundColors.withOpacity(0.2)
                    : index == 2
                        ? AppColors.successColor.withOpacity(0.2)
                        : AppColors.blackColor.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planName,
                  style: AppTextStyle.semiBold20
                      .copyWith(color: AppColors.blackColor),
                ),
                const SizedBox(
                  height: AppSizes.size6,
                ),
                Text(
                  '${AppConstString.rupeesSymbol}$planamount /-',
                  style: AppTextStyle.bold30.copyWith(
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                              ? AppColors.secoundColors
                              : index == 2
                                  ? AppColors.successColor
                                  : AppColors.blackColor
                      // AppColors.appColors

                      ),
                ),
                const SizedBox(
                  height: AppSizes.size6,
                ),
                Text(
                  'including 18% GST',
                  style: AppTextStyle.semiBold12,
                ),
                // Text(
                //   '$planAmountWithoutGst + 18% including GST = ${AppConstString.rupeesSymbol} $planamount -/ RS',
                //   style: AppTextStyle.semiBold12,
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.size20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: AppTextStyle.regular26
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(
                  height: AppSizes.size6,
                ),
                const Divider(
                  color: AppColors.greyColor,
                  thickness: 2,
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: featuresList.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, ind) {
                  return Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: index == 0
                                ? AppColors.blue
                                : index == 1
                                    ? AppColors.secoundColors
                                    : index == 2
                                        ? AppColors.successColor
                                        : AppColors.blackColor,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Text(
                            featuresList[ind],
                            textScaleFactor: 1.0,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size20,
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: PrimaryButton(
              text: 'Purchase Now',
              onTap: onTap,
              color: index == 0
                  ? null
                  : index == 1
                      ? AppColors.secoundColors
                      : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
