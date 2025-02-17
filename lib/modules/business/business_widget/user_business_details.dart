import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';

class UserBusinessDetails extends StatelessWidget {
  final TeamDetailsInfoData? data;
  final BusinessDashboardModel? model;
  const UserBusinessDetails({super.key, this.model, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteColor,
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              offset: Offset(1, 2),
              color: AppColors.containerShaddowbg,
              spreadRadius: 2)
        ],
      ),
      // margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.appLogo,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: AppSizes.size10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customRow(
                  title: 'Rank',
                  value: data != null
                      ? data!.rank != null
                          ? data!.rank.toString()
                          : data!.plan != null
                              ? "Prime Distributor"
                              : "Distributor"
                      : GlobalSingleton.rank == 'null'
                          ? 'Distributor'
                          : GlobalSingleton.rank,
                ),
                customRow(
                  title: 'Name',
                  value: data != null
                      ? data!.name.toString()
                      : '${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}',
                ),
                customRow(
                  title: 'ID',
                  value: data != null
                      ? data!.mlmId.toString()
                      : GlobalSingleton.loginInfo!.data!.mlmId.toString(),
                ),
                customRow(
                  title: 'Mob',
                  value: data != null
                      ? data!.mobile.toString()
                      : GlobalSingleton.loginInfo!.data!.mobile.toString(),
                ),
                customRow(
                    title: 'Joining Date',
                    value: data != null
                        ? data!.joiningDate.toString()
                        : GlobalSingleton.loginInfo!.data!.registrationDate !=
                                null
                            ? DateFormat("dd-MM-yyyy")
                                .parse(GlobalSingleton
                                    .loginInfo!.data!.registrationDate
                                    .toString())
                                .toString()
                                .getSuccessDateFormat
                            : '01-01-2024'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customRow({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.semiBold16,
          ),
          Text(
            ' : ',
            style: AppTextStyle.semiBold16,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyle.semiBold16.copyWith(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
