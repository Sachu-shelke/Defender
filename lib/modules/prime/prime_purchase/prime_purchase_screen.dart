import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/model/prime_plan_model/get_prime_plan_details_model.dart';
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_model.dart';
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_presenter.dart';
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

@RoutePage()
class PrimePlanPurchaseScreen extends StatefulWidget {
  final GetPrimePlanDetailsData data;
  final bool isFromEpin;
  final String? userId;
  const PrimePlanPurchaseScreen(
      {super.key, required this.isFromEpin, this.userId, required this.data});

  @override
  State<PrimePlanPurchaseScreen> createState() =>
      _PrimePlanPurchaseScreenState();
}

class _PrimePlanPurchaseScreenState extends State<PrimePlanPurchaseScreen>
    implements PrimePurchaseView {
  late PrimePurchaseModel model;
  PrimePurchasePresenter presenter = BasicPrimePurchasePresenter();
  int isSelectedWallet = 0;

  @override
  void initState() {
    presenter.updateView = this;
    super.initState();
  }

  @override
  void refreshModel(PrimePurchaseModel primePurchaseModel) {
    model = primePurchaseModel;
    if (mounted) {
      setState(() {});
    }
  }

  int getGstAmount() {
    final gstPrice = double.parse(widget.data.planAmount.toString()) -
        double.parse(widget.data.withoutGst.toString());
    return gstPrice.round();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.isFromEpin.toString());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: '${widget.data.planName} Plan Purchase'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: AppSizes.size10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: CommonStyleDecoration.iconDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizes.size6,
                  ),
                  Text(
                    'Purchase Card Summary',
                    style: AppTextStyle.semiBold16
                        .copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${AppConstString.appName} Prime Membership",
                          style: AppTextStyle.regular16
                              .copyWith(color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${double.parse(widget.data.withoutGst.toString()).floor()}",
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.size10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GSt(18%)",
                        style: AppTextStyle.regular16
                            .copyWith(color: AppColors.greyColor),
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${getGstAmount()}",
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.size10),
                  const Divider(
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(height: AppSizes.size10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstString.totalAmount.tr(),
                        style: AppTextStyle.regular16
                            .copyWith(color: AppColors.greyColor),
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${double.parse(widget.data.planAmount.toString()).floor()}",
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: CommonStyleDecoration.iconDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppConstString.debitFromWallet.tr(),
                      style: AppTextStyle.regular16),
                  const SizedBox(height: AppSizes.size6),
                  const Divider(
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(height: AppSizes.size10),
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.appLogo,
                        height: 45,
                        width: 45,
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Expanded(
                        child: Text(
                          '${AppConstString.appName.tr()} (${GlobalSingleton.walletBalance})',
                          style: AppTextStyle.regular16
                              .copyWith(color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${double.parse(widget.data.planAmount.toString()).floor()}",
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(
                        width: AppSizes.size6,
                      ),
                      InkWell(
                        onTap: () {
                          isSelectedWallet = 0;
                          setState(() {});
                        },
                        child: Icon(
                          isSelectedWallet == 0
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: AppColors.successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: CommonStyleDecoration.iconDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppConstString.debitFromEpin.tr(),
                      style: AppTextStyle.regular16),
                  const SizedBox(height: AppSizes.size6),
                  const Divider(
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(height: AppSizes.size10),
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.appLogo,
                        height: 45,
                        width: 45,
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Expanded(
                        child: Text(
                          '${AppConstString.appName.tr()} (${GlobalSingleton.epinWalletBalance})',
                          style: AppTextStyle.regular16
                              .copyWith(color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${double.parse(widget.data.planAmount.toString()).floor()}",
                        style: AppTextStyle.semiBold16
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(
                        width: AppSizes.size6,
                      ),
                      InkWell(
                        onTap: () {
                          isSelectedWallet = 1;
                          setState(() {});
                        },
                        child: Icon(
                          isSelectedWallet == 1
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: AppColors.successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
          borderRadius: 0,
          onTap: () {
            presenter.planPurchase(
                context: context,
                isSelectedWallet: isSelectedWallet,
                planAmount: widget.data.planAmount.toString(),
                isFromEpin: widget.isFromEpin,
                userId: widget.userId,
                planId: widget.data.id.toString());
          },
          text: 'Proceed To Pay'),
    );
  }
}
