import 'dart:io';

import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';

SystemUiOverlayStyle getStatusBarStyle() {
  return Platform.isAndroid
      ? const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.appColors,
        )
      : const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.appColors,
          systemNavigationBarColor: AppColors.appColors);
}
