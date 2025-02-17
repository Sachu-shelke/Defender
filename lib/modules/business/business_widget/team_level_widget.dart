import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';

class MyLevelTeam extends StatelessWidget {
  final String totalUsers;
  final String activeUsers;
  final String inactiveUsers;
  final String index;
  final bool isOnPress;
  final String planId;
  const MyLevelTeam(
      {super.key,
      required this.totalUsers,
      required this.planId,
      required this.activeUsers,
      required this.inactiveUsers,
      required this.index,
      this.isOnPress = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isOnPress
          ? () {
              context.router.push(
                  PrimeTeamLevelScreenRoute(level: index, primeId: planId));
              // context.router.pushNamed('/Prime_Team_Level_Screen/$index/0');
            }
          : null,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(1, 3),
                color: AppColors.containerShaddowbg,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.appColors,
              child: Text("L$index",
                  textScaleFactor: 1.0,
                  style: AppTextStyle.regular20
                      .copyWith(color: AppColors.whiteColor)),
            ),
            title: Text(
              // "Total Users :  $activeUsers",
              "Total Users :  $totalUsers",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            tileColor: AppColors.whiteColor,
            trailing: const Icon(Icons.chevron_right),
            subtitle: (planId == '0' || planId == '3')
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 6,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(inactiveUsers,
                            textScaleFactor: 1.0,
                            style: AppTextStyle.regular16),
                        const SizedBox(
                          width: 10,
                        ),
                        const CircleAvatar(
                          backgroundColor: AppColors.sucessGreen,
                          radius: 6,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(activeUsers,
                            textScaleFactor: 1.0,
                            style: AppTextStyle.regular16),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
