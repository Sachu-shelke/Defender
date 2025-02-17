import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';

class SnackBars {
  static SnackBar errorSnackBar({required String title}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            textScaleFactor: 1.0,
            style: AppTextStyle.bold14.copyWith(color: AppColors.whiteColor),
          )),
          const Icon(
            Icons.error,
            color: AppColors.whiteColor,
          )
        ],
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
  }

  static SnackBar noInternetSnackBar(
      {required Function onRefresh, String title = 'No Internet Connection'}) {
    return SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text(
        title,
        textScaleFactor: 1.0,
        style: const TextStyle(fontSize: 14),
      ),
      action: SnackBarAction(
          textColor: AppColors.appColors,
          label: 'RETRY',
          onPressed: onRefresh as void Function()),
      backgroundColor: AppColors.blackColor,
      duration: const Duration(seconds: 3),
    );
  }

  static SnackBar commonSnackBar({required String title}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        textScaleFactor: 1.0,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: AppColors.blackColor,
      duration: const Duration(seconds: 3),
    );
  }

  static SnackBar successSnackBar({required String title}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            textScaleFactor: 1.0,
          )),
          const Icon(
            Icons.check,
            color: AppColors.whiteColor,
          ),
        ],
      ),
      backgroundColor: Colors.green,
    );
  }

  // static toast({required String str}) {
  //   Fluttertoast.showToast(
  //     msg: str,
  //     timeInSecForIosWeb: 4,
  //     backgroundColor: Colors.black,
  //     textColor: white,
  //   );
  // }
}
