import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class QrDisplayScreen extends StatefulWidget {
  const QrDisplayScreen({super.key});

  @override
  State<QrDisplayScreen> createState() => _QrDisplayScreenState();
}

class _QrDisplayScreenState extends State<QrDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Mirror QR'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.containerbg,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.blueCircleGradient),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(
                        CommonMethod().initials(
                          firstName: GlobalSingleton.loginInfo!.data!.firstName,
                          lastName: GlobalSingleton.loginInfo!.data!.lastName,
                        ),
                        style: AppTextStyle.semiBold22
                            .copyWith(color: AppColors.whiteColor),
                      )),
                ),
                const SizedBox(
                  width: AppSizes.size10,
                ),
                Text(
                    '${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}',
                    style: AppTextStyle.semiBold22)
              ],
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            QrImageView(
              data: GlobalSingleton.loginInfo!.data!.mobile.toString(),
              version: 5,
              size: 250,
              errorStateBuilder: (cxt, err) {
                return const Center(
                  child: Text(
                    'Uh oh! Something went wrong...',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Text(
              'Scan to pay with Mirror Send Money',
              style: AppTextStyle.regular12,
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: AppSizes.size10,
                ),
                Text(
                  'Mayway Bussiness  Linked wallet A/c',
                  style: AppTextStyle.semiBold16,
                )
              ],
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by',
            style: AppTextStyle.semiBold12.copyWith(color: AppColors.greyColor),
          ),
          Image.asset(
            AppAssets.appLogo,
            height: 40,
            width: 40,
          )
        ],
      ),
    );
  }
}
