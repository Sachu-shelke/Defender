import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: const [
          BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 0),
              color: AppColors.appColors,
              spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        AppConstString.disclaimer.tr(),
        textScaleFactor: 1.0,
      ),
    );
  }
}
