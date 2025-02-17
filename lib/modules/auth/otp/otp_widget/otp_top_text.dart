import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';

class OtpText extends StatelessWidget {
  final String mobileNumber;
  final bool isEditButton;
  final Color? textColor;
  const OtpText(
      {super.key,
      required this.mobileNumber,
      this.textColor,
      this.isEditButton = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppConstString.smsDetectTitle.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? AppColors.blackColor),
              children: <TextSpan>[
                TextSpan(
                    text: " +91 $mobileNumber",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                        fontSize: 18)),
              ],
            ),
          ),
        ),
        isEditButton
            ? IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : Container()
      ],
    );
  }
}
