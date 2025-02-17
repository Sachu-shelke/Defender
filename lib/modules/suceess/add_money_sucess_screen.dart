import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class AddMoneySucessScreen extends StatefulWidget {
  const AddMoneySucessScreen({super.key});

  @override
  State<AddMoneySucessScreen> createState() => _AddMoneySucessScreenState();
}

class _AddMoneySucessScreenState extends State<AddMoneySucessScreen> {
  double? height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: AppSizes.size50,
                    ),
                    const SizedBox(
                      height: AppSizes.size50,
                    ),
                    Lottie.asset(
                      AppAssets.yellowRightCircle,
                      width: 300,
                    ),
                    const SizedBox(
                      height: AppSizes.size20,
                    ),
                    Text(
                      'Request Successful',
                      style: AppTextStyle.bold20
                          .copyWith(color: AppColors.blackColor),
                    ),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Your money is on its way and will be added to your wallet within one working day from the receive it.',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.regular16.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // const Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: 40),
            //     child: Banners(
            //       localModel: [AppAssets.referBanner],
            //     ),
            //   ),
            // )
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: GestureDetector(
            //     onVerticalDragUpdate: (details) {
            //       if (details.primaryDelta! > 0) {
            //         // Positive primaryDelta indicates a downward drag
            //         setState(() {
            //           height = null;
            //           // dragDirection = 'Down';
            //         });
            //       } else if (details.primaryDelta! < 0) {
            //         // Negative primaryDelta indicates an upward drag
            //         setState(() {
            //           height = (MediaQuery.of(context).size.height / 1.1);
            //           // dragDirection = 'Up';
            //         });
            //       }
            //     },
            //     child: AnimatedContainer(
            //       alignment: Alignment.center,
            //       duration: const Duration(milliseconds: 400),
            //       height: height ?? (MediaQuery.of(context).size.height / 2.5),
            //       decoration: const BoxDecoration(
            //         color: AppColors.secoundColors,
            //         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            //       ),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           CarouselSlider(
            //             options: CarouselOptions(
            //               aspectRatio: 1.5,
            //               autoPlay: true,
            //               viewportFraction: 1,
            //               enableInfiniteScroll: false,
            //               disableCenter: false,
            //               padEnds: false,
            //             ),
            //             items: List.generate(
            //               5,
            //               (index) => SizedBox(
            //                 // height: 85,
            //                 child: Image.asset(
            //                   AppAssets.ban,
            //                   fit: BoxFit.fill,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: PrimaryButton(
            borderRadius: 0,
            onTap: () {
              CustomModalBottomSheet.show(
                  context: context, serviceName: 'Add Money');
              // context.router.push(MainHomeScreenRoute(isFromSignup: false));
            },
            text: AppConstString.done.tr())
        // InkWell(
        //   onTap: () {
        //     context.router.push(MainHomeScreenRoute(isFromSignup: false));
        //   },
        //   child:
        //   SizedBox(
        //     height: 40,
        //     width: MediaQuery.of(context).size.width,
        //     child: Center(
        //       child: Text(
        //         AppConstString.done,
        //         style: AppTextStyle.black20.copyWith(color: AppColors.appColors),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
