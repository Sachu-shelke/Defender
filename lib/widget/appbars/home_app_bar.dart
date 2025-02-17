import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_screen.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function onTap;
  final bool isPrime;
  final String title;
  const HomeAppBar(
      {super.key,
      required this.onTap,
      this.isPrime = false,
      required this.title});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return GlobalUpdateNotifier(
      onGlobalUpdate: () {
        setState(() {});
      },
      child: AppBar(
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        backgroundColor: AppColors.appColors,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: Row(
          children: [
            Text('Mayway Bussiness ',
                // GlobalSingleton.businessCompanyProfile == true
                //     ? 'Mirror Infotech'
                //     : "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}"
                //         .toTitleCase(),
                textScaleFactor: 1.0,
                style: AppTextStyle.semiBold20
                    .copyWith(color: AppColors.whiteColor)),
            if (widget.isPrime) ...[
              const SizedBox(width: 10),
              const Text(
                "Prime",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            ]
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const NotificationScreenRoute());
            },
            icon: const Icon(
              Icons.notifications,
              // color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
