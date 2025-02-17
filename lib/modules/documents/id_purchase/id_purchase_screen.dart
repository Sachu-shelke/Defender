// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/modules/suceess/id_card_sucess_screen.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

class IdPurchaseScreen extends StatefulWidget {
  final String addressType;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String phoneNumber;
  const IdPurchaseScreen({
    super.key,
    required this.addressType,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.phoneNumber,
  });

  @override
  State<IdPurchaseScreen> createState() => _IdPurchaseScreenState();
}

class _IdPurchaseScreenState extends State<IdPurchaseScreen> {
  int isSelectedWallet = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppBar(title: 'ID Card Purchase'),
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
                    'Purchase ID Card Summary',
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
                          "${AppConstString.appName} ID Card",
                          style: AppTextStyle.regular16
                              .copyWith(color: AppColors.greyColor),
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.size10,
                      ),
                      Text(
                        "${AppConstString.rupeesSymbol} ${double.parse("99".toString()).floor()}",
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
                        "${AppConstString.rupeesSymbol} 17",
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
                        "${AppConstString.rupeesSymbol} ${double.parse("99").floor()}",
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
                        "${AppConstString.rupeesSymbol} ${double.parse("99").floor()}",
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
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   decoration: CommonStyleDecoration.iconDecoration(),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(AppConstString.debitFromEpin.tr(),
            //           style: AppTextStyle.regular16),
            //       const SizedBox(height: AppSizes.size6),
            //       const Divider(
            //         color: AppColors.greyColor,
            //       ),
            //       const SizedBox(height: AppSizes.size10),
            //       Row(
            //         children: [
            //           Image.asset(
            //             AppAssets.appLogo,
            //             height: 45,
            //             width: 45,
            //           ),
            //           const SizedBox(
            //             width: AppSizes.size10,
            //           ),
            //           Expanded(
            //             child: Text(
            //               '${AppConstString.appName.tr()} (${GlobalSingleton.epinWalletBalance})',
            //               style: AppTextStyle.regular16
            //                   .copyWith(color: AppColors.greyColor),
            //             ),
            //           ),
            //           const SizedBox(
            //             width: AppSizes.size10,
            //           ),
            //           Text(
            //             "${AppConstString.rupeesSymbol} ${double.parse("99").floor()}",
            //             style: AppTextStyle.semiBold16
            //                 .copyWith(color: AppColors.blackColor),
            //           ),
            //           const SizedBox(
            //             width: AppSizes.size6,
            //           ),
            //           InkWell(
            //             onTap: () {
            //               isSelectedWallet = 1;
            //               setState(() {});
            //             },
            //             child: Icon(
            //               isSelectedWallet == 1
            //                   ? Icons.check_circle
            //                   : Icons.circle_outlined,
            //               color: AppColors.successColor,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
          borderRadius: 0,
          onTap: () {
            idPurchase(context: context);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const IdCardSucessScreen()));
            // presenter.planPurchase(
            //     context: context,
            //     isSelectedWallet: isSelectedWallet,
            //     planAmount: widget.data.planAmount.toString(),
            //     isFromEpin: widget.isFromEpin,
            //     userId: widget.userId,
            //     planId: widget.data.id.toString());
          },
          text: 'Proceed To Pay'),
    );
  }

  Future<void> idPurchase({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.idCardPurchase,
        data: {
          "user_id": GlobalSingleton.loginInfo!.data!.id.toString(),
          "mlm_id": GlobalSingleton.loginInfo!.data!.mlmId.toString(),
          "name":
              "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
          "city": widget.city,
          "state": widget.state,
          "address_type": widget.addressType,
          "pincode": widget.zip,
          "mobile_no": widget.phoneNumber,
          "address": widget.address
        },
        context: context);

    log(response.toString());
    if (response != null && response['status'] == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const IdCardSucessScreen()));
    }
    setState(() {});
  }
}
