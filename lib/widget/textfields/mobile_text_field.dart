import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/utils/validator.dart';

class MobileTextField extends StatelessWidget {
  final TextEditingController? _controller;
  final String labelTextStrr;
  final void Function(String)? onChanged;
  final String? countryId;
  final bool enabled;
  final String? dailCode;
  final bool isBorder;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Color? color;
  final BorderRadius? borderRadius;

  const MobileTextField(
    this._controller, {
    this.labelTextStrr = 'Mobile Number',
    this.onChanged,
    this.isBorder = true,
    this.borderRadius,
    this.color,
    this.suffixWidget,
    this.prefixWidget,
    this.dailCode,
    this.enabled = true,
    this.countryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: _controller,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: Validators.validateMobileNumber,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: .10),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.digitsOnly
        ],
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelTextStrr,
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: AppColors.appColors, width: 0.8),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            borderSide: BorderSide(
              width: isBorder ? 0.8 : 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: const Icon(Icons.phone),
          prefixText: '+91 ',
          prefixStyle: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: color ?? AppColors.containerbg,
          suffix: suffixWidget,
          isDense: true,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class MobileTextFieldrecharge extends StatelessWidget {
  final TextEditingController? _controller;
  final String labelTextStrr;
  final void Function(String)? onChanged;
  final String? countryId;
  final bool enabled;
  final String? dailCode;
  final bool isBorder;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const MobileTextFieldrecharge(
    this._controller, {
    this.labelTextStrr = 'Mobile Number',
    this.onChanged,
    this.isBorder = true,
    this.borderRadius,
    this.color,
    this.suffixWidget,
    this.prefixWidget,
    this.dailCode,
    this.padding,
    this.enabled = true,
    this.countryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: _controller,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: Validators.validateMobileNumber,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: .10),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.digitsOnly
        ],
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelTextStrr,
          focusedBorder: const OutlineInputBorder(
            // borderRadius: borderRadius ?? BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.appColors, width: 0.8),
          ),
          border: OutlineInputBorder(
            // borderRadius: borderRadius ?? BorderRadius.circular(20),
            borderSide: BorderSide(
              width: isBorder ? 0.8 : 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: const Icon(
            Icons.phone,
            color: AppColors.appColors,
          ),
          prefixText: '+91 ',
          prefixStyle: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: color ?? AppColors.containerbg,
          suffixIcon: suffixWidget,
          isDense: true,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
