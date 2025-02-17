import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_sizes.dart';

class AppBackGroundWidget extends StatelessWidget {
  const AppBackGroundWidget(
      {super.key, this.backgroundColor, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: backgroundColor ?? AppColors.backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.size10,
                // right: AppSizes.size10,
                top: AppSizes.size10),
            child: ClipRRect(
              child: Container(
                padding: padding ??
                    const EdgeInsets.only(
                        left: AppSizes.size10,
                        right: AppSizes.size10,
                        top: AppSizes.size20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
