import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final bool showShadow;
  final Function()? onTap;
  final Color? color;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final double? height, width, borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    this.color,
    this.height,
    this.gradient,
    this.width,
    this.textStyle,
    this.showShadow = false,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? AppSizes.size50,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: color == null ? gradient ?? AppColors.circleGradient : null,
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.size14),
          boxShadow: showShadow
              ? <BoxShadow>[
                  const BoxShadow(
                    color: AppColors.brownishColor,
                    blurRadius: 60,
                    offset: Offset(20, 20),
                  ),
                ]
              : [],
        ),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: textStyle ??
              AppTextStyle.bold18.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
      ),
    );
  }
}

class AnimatedPrimaryButton extends StatefulWidget {
  final String text;
  final bool showShadow;
  final Function() onTap;
  final bool isOntapValid;
  final Color? tColor, bColor;
  final Color? color;
  final TextStyle? textStyle;
  final double? height, width, borderRadius;
  final Gradient? gradient;
  const AnimatedPrimaryButton({
    super.key,
    required this.text,
    this.tColor,
    this.bColor,
    this.height,
    this.gradient,
    this.color,
    this.width,
    required this.isOntapValid,
    this.textStyle,
    this.showShadow = false,
    this.borderRadius,
    required this.onTap,
  });

  @override
  State<AnimatedPrimaryButton> createState() => _AnimatedPrimaryButtonState();
}

class _AnimatedPrimaryButtonState extends State<AnimatedPrimaryButton> {
  double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isOntapValid == true) {
          width = 0;
          Future.delayed(const Duration(seconds: 1), () {
            width = null;
            setState(() {});
          });
        }

        Future.delayed(const Duration(milliseconds: 600), () {
          widget.onTap();
        });
        setState(() {});
      },
      child: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 400),
          height: widget.height ?? AppSizes.size50,
          width: width ?? (widget.width ?? MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
            gradient: widget.color == null
                ? widget.gradient ?? AppColors.circleGradient
                : null,
            color: widget.color,
            // gradient: widget.gradient ?? AppColors.circleGradient,
            borderRadius:
                BorderRadius.circular(widget.borderRadius ?? AppSizes.size14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.brownishColor,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Text(
            width == null ? widget.text.toString() : "",
            style: AppTextStyle.bold20.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
