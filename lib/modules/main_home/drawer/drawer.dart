// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/documents/id_card_page.dart';
import 'package:defenders/modules/documents/prime_invoice_page.dart';
import 'package:defenders/modules/ebook/add_ebook/add_book_screen.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen.dart';
import 'package:defenders/modules/hold_income_passbook/hold_income_passbook_screen.dart';
import 'package:defenders/modules/loan/business_loan/business_loan_screen.dart';
import 'package:defenders/modules/marketing/brochure_screen.dart';
import 'package:defenders/modules/profile/profile_screen.dart';
import 'package:defenders/modules/today_task/my_contact_screen.dart';
import 'package:defenders/utils/google_Ads.dart';
import 'package:defenders/widget/logo.dart';
import 'package:path_provider/path_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.containerbg,
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(gradient: AppColors.circleGradient),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Logo(
                    imageUrl: GlobalSingleton.profilePic,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: AppSizes.size10,
            // ),
            // Container(
            //   // color: AppColors.whiteColor,
            //   decoration: CommonStyleDecoration.iconDecoration(),
            //   margin: const EdgeInsets.all(5),
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: ListTile(
            //     leading: Container(
            //       decoration: BoxDecoration(
            //         color: AppColors.greyColor.withOpacity(0.3),
            //         shape: BoxShape.circle,
            //       ),
            //       child: const Icon(
            //         Icons.person,
            //         color: AppColors.darkgreyColor,
            //         size: 50,
            //       ),
            //     ),
            //     title: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
            //           style: AppTextStyle.bold16,
            //         ),
            //         Text(
            //           '+91 ${GlobalSingleton.loginInfo!.data!.mobile}',
            //           style: AppTextStyle.semiBold14,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Divider(
              color: AppColors.blackColor,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            customAppListTile(
                icon: AppAssets.d9,
                title: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(
                        isFromDrawer: true,
                      ),
                    ),
                  );
                }),
            // customAppListTile(
            //     icon: AppAssets.d7,
            //     title: 'Mirror Traning',
            //     onTap: () {
            //       Navigator.pop(context);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const TrainingMeetingDashboardPage(
            //             isFromMain: false,
            //           ),
            //         ),
            //       );
            //     }),
            customAppListTile(
                icon: AppAssets.d5,
                title: 'E-pin',
                onTap: () {
                  Navigator.pop(context);
                  context.router.push(RedeemScreenRoute(isFromEwallet: true));
                }),
            customAppListTile(
                icon: AppAssets.d5,
                title: 'E-Book',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddBookScreen(),
                    ),
                  );
                }),
            customAppListTile(
                icon: AppAssets.d4,
                title: 'Loan',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BusinessLoanScreen(),
                    ),
                  );
                }),
            customAppListTile(
                icon: AppAssets.d1,
                title: 'Prime',
                onTap: () {
                  Navigator.pop(context);
                  context.router
                      .push(PrimeDashboardScreenRoute(isFromEpin: false));
                }),
            customAppListTile(
                icon: AppAssets.d1,
                title: 'Brochure',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BrochureScreen(),
                    ),
                  );
                }),
            // customAppListTile(
            //     icon: AppAssets.d8,
            //     title: 'Become a seller',
            //     onTap: () {
            //       Navigator.pop(context);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const VendorScreen(
            //             url: 'https://mirrorhub.in/shop/apply',
            //           ),
            //         ),
            //       );
            //     }),
            customAppListTile(
                icon: AppAssets.d6,
                title: 'Reward Passbook',
                onTap: () {
                  Navigator.pop(context);
                  context.router
                      .push(IncomePassbookScreenRoute(isFromDrawer: true));
                }),
            customAppListTile(
                icon: AppAssets.d6,
                title: 'Hold Passbook',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HoldIncomePassbookScreen(
                                isFromDrawer: true,
                              )));
                  // context.router
                  //     .push(IncomePassbookScreenRoute(isFromDrawer: true));
                }),
            customAppListTile(
                icon: AppAssets.d5,
                title: 'Redeem',
                onTap: () {
                  Navigator.pop(context);
                  context.router.push(RedeemScreenRoute(isFromEwallet: false));
                }),

            // customAppListTile(
            //     icon: Icons.redeem_outlined,
            //     title: 'Phone Pe',
            //     onTap: () {
            //       Navigator.pop(context);
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const PhonePeScreen()));
            //     }),
            // customAppListTile(
            //     icon: Icons.redeem_outlined,
            //     title: 'Refer',
            //     onTap: () {
            //       Navigator.pop(context);
            //       CommonMethod.referLink(
            //           referCode:
            //               GlobalSingleton.loginInfo!.data!.mobile.toString(),
            //           name:
            //               "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
            //     }),
            if (StorageManager.getIntValue('isPrime') == 1)
              customAppListTile(
                  icon: AppAssets.d10,
                  title: 'Invoice',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrimeInvoiceScreen()));
                  }),
            if (StorageManager.getIntValue('isPrime') == 1)
              customAppListTile(
                  icon: AppAssets.d7,
                  title: 'ID Card',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IdCardScreen()));
                  }),
            customAppListTile(
                icon: AppAssets.d10,
                title: 'Feedback',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedbackScreen(),
                    ),
                  );
                }),
            customAppListTile(
                icon: AppAssets.todayCall,
                title: 'My Contact',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyContactScreen(),
                    ),
                  );
                }),
            customAppListTile(
                icon: AppAssets.d3,
                title: 'Logout',
                onTap: () async {
                  Navigator.pop(context);

                  // Get the application documents directory
                  Directory appDir = await getApplicationDocumentsDirectory();

                  // Check if the directory exists
                  if (appDir.existsSync()) {
                    // Delete the directory and its contents
                    appDir.deleteSync(recursive: true);
                  }

                  StorageManager.clearSharedPreferences();
                  context.router.pushAndPopUntil(
                    const LoginScreenRoute(),
                    predicate: (route) => false,
                  );
                }),
            const GoogleAdsScreen(),
            if (Platform.isAndroid)
              const SizedBox(
                // height: 30,
                child: Align(
                  //padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Ver ${AppConstString.appVersion}",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            letterSpacing: 0.8),
                      ),
                      Text(
                        "App Designed and Developed by MirrorInfo Tech Pvt Ltd",
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            letterSpacing: 0.8),
                      ),
                      Text(
                        AppConstString.ownersNumber,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            letterSpacing: 0.8),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }

  Widget customAppListTile(
      {required String icon, required String title, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 30,
              width: 30,
              // color: AppColors.appColors,
            ),
            const SizedBox(
              width: AppSizes.size10,
            ),
            Text(
              title,
              style: AppTextStyle.semiBold16,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: AppColors.appColors,
            )
          ],
        ),
      ),
    );
  }
}
