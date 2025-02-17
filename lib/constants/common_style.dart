import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';

class CommonStyle {
  static BoxShadow boxShadow({double blurRadius = 4}) {
    return BoxShadow(
        blurRadius: blurRadius,
        offset: const Offset(1, 3),
        color: const Color.fromRGBO(0, 0, 0, 0.1),
        spreadRadius: 0);
  }
}

class CommonStyleDecoration {
  static BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: AppColors.secoundColors,
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            offset: Offset(1, 2),
            color: AppColors.secoundColors,
            spreadRadius: 2)
      ],
      borderRadius: BorderRadius.circular(20.0),
    );
  }

  static BoxDecoration serviceBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: AppColors.appColors,
      ),
      boxShadow: [
        BoxShadow(
            blurRadius: 2,
            offset: const Offset(1, 1),
            color: AppColors.appColors.withOpacity(0.5),
            spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static BoxDecoration incomeBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: AppColors.whiteColor,
      ),
      boxShadow: [
        BoxShadow(
            blurRadius: 2,
            offset: const Offset(1, 1),
            color: AppColors.appColors.withOpacity(0.5),
            spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static BoxDecoration iconDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      border: Border.all(
        color: AppColors.appColors,
      ),
      // boxShadow: [
      //   BoxShadow(
      //       blurRadius: 3,
      //       offset: Offset(2, 4),
      //       color: AppColors.secoundColors.withOpacity(0.5),
      //       spreadRadius: 1)
      // ],
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  static BoxDecoration itemDecoration() {
    return BoxDecoration(
      color: AppColors.secoundColors,
      boxShadow: const [
        BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 0),
            color: AppColors.appColors,
            spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(20.0),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
