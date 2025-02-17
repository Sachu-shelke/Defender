import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldStyle {
  static TextStyle labelStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: .10);
  }

  static OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 0.8,
        style: BorderStyle.none,
      ),
    );
  }

  static OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColors.appColors, width: 0.8),
    );
  }
}
