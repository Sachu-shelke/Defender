import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';

class NoTransaction extends StatelessWidget {
  final String str;

  const NoTransaction({super.key, this.str = 'No Transaction Found'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            str,
            textScaleFactor: 1.0,
            style: AppTextStyle.semiBold16,
          ),
        ],
      ),
    );
  }
}
