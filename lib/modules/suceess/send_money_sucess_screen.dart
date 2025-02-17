import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SendMoneySuccessScreen extends StatefulWidget {
  final String title;
  final String? cashback;
  final String? operator;
  final String? mobileNumber;
  final String? reference;
  final String? transaction;
  const SendMoneySuccessScreen(
      {super.key,
      this.title = "Your request has been successfully processed..!",
      this.cashback,
      this.mobileNumber,
      this.operator,
      this.reference,
      this.transaction});

  @override
  State<SendMoneySuccessScreen> createState() =>
      _SendMoneySuccessScreenScreenState();
}

class _SendMoneySuccessScreenScreenState extends State<SendMoneySuccessScreen>
    with TickerProviderStateMixin {
  // late final AnimationController _controller;

  int? selectedRatingStar;
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: "CONFIRMATION"),
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            text: "OK",
            borderRadius: 0,
            onTap: () {
              CustomModalBottomSheet.show(
                  context: context, serviceName: 'Send Money');
              // context.router.push(MainHomeScreenRoute(isFromSignup: false));
              // widget.cashback != null
              //     ? widget.cashback == "0.0" || widget.cashback == "0"
              //         ? _showPopUp(crn: context)
              //         // context.router.pushAndPopUntil(MainRoute(),
              //         //     predicate: (route) => false)
              //         : _rechargeConfirmController.isGuaranteed.value == 1
              //             ? _showPopUp(crn: context)
              //             // context.router.pushAndPopUntil(MainRoute(),
              //             //     predicate: (route) => false)
              //             : context.router.pushAndPopUntil(
              //                 CashBackAnimationRoute(
              //                     serviceName: widget.serviceName,
              //                     cb: widget.cashback),
              //                 predicate: (route) => false)
              //     : _showPopUp(crn: context);
              // context.router.pushAndPopUntil(MainRoute(),
              //     predicate: (route) => false);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.appColors,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 600,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        AppAssets.yellowRightCircle,
                        width: 200,
                      ),
                      // Lottie.asset('assets/animation/success.json',
                      //     controller: _controller, onLoaded: (composition) {
                      //   _controller
                      //     ..duration = composition.duration
                      //     ..forward();
                      // }, fit: BoxFit.cover, height: 100, width: 100),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBold18,
                      ),
                      const SizedBox(
                        height: AppSizes.size10,
                      ),
                      // Text(
                      //   'Amount',
                      //   style: AppTextStyle.semiBold14
                      //       .copyWith(color: AppColors.greyColor),
                      // ),
                      // const SizedBox(
                      //   height: AppSizes.size4,
                      // ),
                      Text(
                        AppConstString.rupeesSymbol +
                            widget.cashback.toString(),
                        style: AppTextStyle.semiBold20,
                      ),
                      const SizedBox(
                        height: AppSizes.size4,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reference Id',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                          Text(
                            widget.transaction.toString(),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),

                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mobile',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                          Text(
                            widget.mobileNumber.toString(),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transfer From ',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                          Text(
                            "${AppConstString.appName} Wallet",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                          Text(
                            DateTime.now().toString().getDateTime,
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular16,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: AppSizes.size20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSizes.size20,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Banners(
                    localModel: [AppAssets.referBanner],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}
