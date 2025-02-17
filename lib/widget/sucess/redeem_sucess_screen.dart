// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;

import 'package:share_plus/share_plus.dart';

@RoutePage()
class RedeemSucessScreen extends StatefulWidget {
  final String redeemAmount;
  final String redeemNumbeer;
  const RedeemSucessScreen(
      {super.key, required this.redeemNumbeer, required this.redeemAmount});

  @override
  State<RedeemSucessScreen> createState() => _RedeemSucessScreenState();
}

class _RedeemSucessScreenState extends State<RedeemSucessScreen> {
  double? height;
  ScreenshotController screenshotController = ScreenshotController();
  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.redeemBackground),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          size: 100,
                          color: Colors.white,
                        ),
                        Text(
                          '${AppConstString.rupeesSymbol} ${widget.redeemAmount}',
                          style: AppTextStyle.semiBold24
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          'Your Request\nAdded Successfull',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semiBold24
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: AppSizes.size50,
                  // ),
                  // const SizedBox(
                  //   height: AppSizes.size50,
                  // ),
                  // Lottie.asset(
                  //   AppAssets.yellowRightCircle,
                  //   width: 300,
                  // ),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  // Text(
                  //   'Request Successful',
                  //   style: AppTextStyle.bold20
                  //       .copyWith(color: AppColors.blackColor),
                  // ),
                  // const SizedBox(
                  //   height: AppSizes.size10,
                  // ),
                  Text(
                    'It will be credited in next 24 hours',
                    // 'Your redeem request is on its way and will be added to your balance within one working day from the receive it.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular16.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                            color: AppColors.greyColor.withOpacity(0.5),
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text('Slip Number'),
                        Text(widget.redeemNumbeer),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text('Order Date'),
                        Text(DateTime.now().toString().getDateTime),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text('Mirrorinfo Tech PVT. LTD'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          // borderRadius: 0,
                          text: 'Share Now',
                          onTap: () {
                            _imageShare();
                          },
                          gradient: AppColors.organeCircleGradient,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PrimaryButton(
                            // borderRadius: 0,
                            onTap: () {
                              CustomModalBottomSheet.show(
                                  context: context, serviceName: 'Redeem');
                            },
                            text: AppConstString.done.tr()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  if (GlobalSingleton.bannerList != null &&
                      GlobalSingleton.bannerList!.isNotEmpty)
                    Banners(
                      model: (GlobalSingleton.bannerList != null)
                          ? GlobalSingleton.bannerList ?? []
                          : null,
                    ),
                  const SizedBox(
                    height: AppSizes.size10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     PrimaryButton(
      //       text: 'Share Now',
      //       borderRadius: 0,
      //       onTap: () {
      //         _imageShare();
      //       },
      //       gradient: AppColors.organeCircleGradient,
      //     ),
      //     PrimaryButton(
      //         borderRadius: 0,
      //         onTap: () {
      //           CustomModalBottomSheet.show(
      //               context: context, serviceName: 'Redeem');
      //         },
      //         text: AppConstString.done.tr()),
      //   ],
      // ),
    );
  }

  _imageShare() async {
    try {
      pixelRatio = math.max(heightRatio, widthRatio);

      await screenshotController
          .capture(
              pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.jpeg').create();
          await imagePath.writeAsBytes(image);
          await Share.shareXFiles([XFile(imagePath.path)]);
        }
      });
    } catch (e) {}
  }
}
